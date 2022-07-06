import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Shared/Constants.dart';
import '../../services/API/APIManager.dart';

class bookmarksPage extends StatefulWidget
{
  List<Bookmark> bookmarks;
  bookmarksPage(this.bookmarks);

  @override
  State<bookmarksPage> createState() => _bookmarksPageState();
}

class _bookmarksPageState extends State<bookmarksPage> {
  AppProvider provider;
  @override
  Widget build(BuildContext context) {

    provider = Provider.of<AppProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 70.0,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),
          backgroundColor: Colors.blueGrey,
          title: Text(" Bookmarks "),
          centerTitle: true,
        ),
        drawer: Appdrawer(context),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 1, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.blueGrey,
                  );
                },
                shrinkWrap: true,
                itemCount: widget.bookmarks.length,
                itemBuilder: (context, index) => Slidable(
                  key: UniqueKey(),

                  // dismissal: SlidableDismissal(
                  //   child: SlidableDrawerDismissal(),
                  // onDismissed: (type) async {
                  //     final action = type == SlideActionType.primary?
                  //         SlidableAction.headTo: SlidableAction.delete;
                  //     await onDismissed(index, action);
                  // },),
                  actionPane: SlidableDrawerActionPane(),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: bookmarkListTile(widget.bookmarks[index].name),
                  ),

                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Head to ',
                      color: Colors.blueGrey,
                      icon: Icons.directions,
                      onTap: ()
                      async {
                        await onDismissed(index, SlidableAction.headTo);
                      },
                    )
                  ],

                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.green,
                      icon: Icons.share,
                      onTap: ()
                      async {
                        await onDismissed(index, SlidableAction.share);
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: ()
                      async {
                        await onDismissed(index, SlidableAction.delete);

                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookmarkListTile(String name) {
    return Builder(
      builder: (context) {
        return ListTile(
            title: Text(name, style:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
                overflow:  TextOverflow.fade),
            onTap: (){
              final slidable = Slidable.of(context);
              final isClosed = slidable.renderingMode == SlidableRenderingMode.none;

              if(isClosed)
                  slidable.open(actionType: SlideActionType.secondary);

              else
                slidable.close();
            },
          );
      }
    );
    }


  Future<void> onDismissed(int index, SlidableAction action) async
  {
    String message;
    switch(action)
    {
      case SlidableAction.delete:
        int code = await deleteBookmark(widget.bookmarks[index].id, provider.currentUser.token);
        setState(()  {
          if (code == 200)
          {
            widget.bookmarks.removeAt(index);
            message = "bookmark deleted successfully";
          }
        });
        break;

      case SlidableAction.headTo:
        message = "directing to google maps...";
        String url = widget.bookmarks[index].locationURL;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;

      case SlidableAction.share:
        message = "bookmark shared successfully";
        break;
    }

    setState(() {
      final snackBar = SnackBar(content:  Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

  }
}