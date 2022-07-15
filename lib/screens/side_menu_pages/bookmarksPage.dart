import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Network/API/Bookmarks.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../Shared/Functions.dart';

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
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Delete all bookmarks'),
                    onTap: () {
                      Future.delayed(
                          const Duration(seconds: 0),
                              () => showDialog(
                            context: context,
                            builder: (context) =>  AlertDialog(
                              title: Text('Do you want to delete all bookmarks? ', style: TextStyle(color: Colors.blueGrey)),
                              actions:   [
                                TextButton(
                                  key: Key("yes"),
                                  child: Text("Yes",style: TextStyle(color: Colors.black)),
                                  onPressed: ()  async {
                                    int status = await clearDriverBookmarks(widget.bookmarks[0].driverID, provider.currentUser.token);
                                    if(status == 200)
                                    {
                                      setState(() {
                                        widget.bookmarks.clear();
                                      });
                                      final snackBar = SnackBar(content:  Text('bookmarks removed'));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                     Navigator.pop(context,'delete');
                                  },
                                ),

                                TextButton(
                                  key: Key("no"),
                                  child: Text("No",style: TextStyle(color: Colors.black)),
                                  onPressed: () =>
                                      Navigator.pop(context,'Cancel'),
                                ),

                              ],
                            ),
                          ));
                    },
                  )
                ])
          ],
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

        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Flexible(
            child: Container(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height* 1/96,
                  );
                },
                shrinkWrap: true,
                itemCount: widget.bookmarks.length,
                itemBuilder: (context, index) => Slidable(
                  key: UniqueKey(),

                  actionExtentRatio: 0.20,
                  actionPane: SlidableDrawerActionPane(),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: bookmarkItem(widget.bookmarks[index].name)
                  ),

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
                      caption: 'Head to ',
                      color: Colors.blueGrey,
                      icon: Icons.directions,
                      onTap: ()
                      async {
                        await onDismissed(index, SlidableAction.headTo);
                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: ()
                      async {
                        showDialog(context: context, builder: (BuildContext context)=>AlertDialog(
                          content:  Text("Do you want to delete bookmark?", style: TextStyle(color: Colors.blueGrey)),
                          actions: [
                            TextButton(
                              key: Key("yes"),
                              child: Text("Yes",style: TextStyle(color: Colors.black),),
                              onPressed: ()
                             async {
                                await onDismissed(index, SlidableAction.delete);
                                Navigator.pop(context,'Cancel');
                              },
                            ),
                            TextButton(
                              key: Key("no"),
                              child: Text("No",style: TextStyle(color: Colors.black)),
                              onPressed: () =>
                                  Navigator.pop(context,'Cancel'),
                            ),
                          ],
                        ));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
    
    Widget bookmarkItem(String name)
    {
      return Builder(
        builder: (context){
          return GestureDetector(
            child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(name, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
                        overflow:  TextOverflow.fade),
                  )
                ),
            ),
            onTap: (){
              final slidable = Slidable.of(context);
              final isClosed = slidable.renderingMode == SlidableRenderingMode.none;

              if(isClosed)
                slidable.open(actionType: SlideActionType.secondary);

              else
                slidable.close();
            },
            
          );
        },
      );
          
    }

  Future<void> onDismissed(int index, SlidableAction action) async
  {
    String message;
    String url = widget.bookmarks[index].locationURL;
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
          else
            message = "couldn't delete bookmark";
        });
        break;

      case SlidableAction.headTo:
        if (await canLaunchUrlString(url)) {
          message = "directing to google maps...";
          await launchUrlString(url);
        } else {
          message = "Could not launch url";
          throw 'Could not launch $url';
        }
        break;

      case SlidableAction.share:
        final box = context.findRenderObject() as RenderBox;
        await Share.share(url, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        message = "bookmark shared successfully";
        break;
    }

    final snackBar = SnackBar(content:  Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

}