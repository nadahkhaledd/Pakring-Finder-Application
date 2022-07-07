import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/DBModels/Recent.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import '../../Shared/Functions.dart';
import '../../services/API/APIManager.dart';

class historyPage extends StatefulWidget
{
  Recent history;
  historyPage(this.history);

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
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
          title: Text(" History "),
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
                itemCount: widget.history.history.length,
                itemBuilder: (context, index) => Slidable(
                  key: UniqueKey(),

                  // dismissal: SlidableDismissal(
                  //   child: SlidableDrawerDismissal(),
                  // onDismissed: (type) async {
                  //     final action = type == SlideActionType.primary?
                  //         SlidableAction.headTo: SlidableAction.share;
                  //     await onDismissed(index, action);
                  // },),

                  actionExtentRatio: 0.20,
                  actionPane: SlidableDrawerActionPane(),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: historyListTile(widget.history.history[index].address),

                  ),

                  secondaryActions: <Widget>[
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
                      caption: 'Share',
                      color: Colors.green,
                      icon: Icons.share,
                      onTap: ()
                      async {
                        await onDismissed(index, SlidableAction.share);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyListTile(String name) {
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
    String url = widget.history.history[index].locationURL;
    switch(action)
    {
      case SlidableAction.headTo:
        if (await canLaunch(url)) {
          message = "directing to google maps...";
          await launch(url);
        } else {
          message = "Could not launch url";
          throw 'Could not launch $url';
        }
        break;

      case SlidableAction.share:
        final box = context.findRenderObject() as RenderBox;
        await Share.share(url);
        message = "bookmark shared successfully";
        break;
    }

    final snackBar = SnackBar(content:  Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }
}