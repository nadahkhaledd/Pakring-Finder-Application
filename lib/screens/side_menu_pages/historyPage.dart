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
import '../../Network/API/Recents.dart';
import '../../Shared/Functions.dart';
import '../../widgets/cardItem.dart';


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

    if(widget.history.history != null)
      widget.history.history = widget.history.history.reversed.toList();

    provider = Provider.of<AppProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child:Text('clear history'),
                    onTap:()  {
                      Future.delayed(
                          const Duration(seconds: 0),
                              () => showDialog(
                            context: context,
                            builder: (context) =>  AlertDialog(
                              title: Text('Do you want to clear history? ', style: TextStyle(color: Colors.blueGrey)),
                              actions:   [
                                TextButton(
                                  key: Key("yes"),
                                  child: Text("Yes",style: TextStyle(color: Colors.black)),
                                  onPressed: ()  async {
                                    int status = await clearHistory(widget.history.driverID, provider.currentUser.token);
                                    if(status == 200)
                                    {
                                      setState(() {
                                        widget.history.history.clear();
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
                  ),
                ])
          ],
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
                itemCount: widget.history.history.length,
                itemBuilder: (context, index) => Slidable(
                  key: UniqueKey(),
                  actionExtentRatio: 0.20,
                  actionPane: SlidableDrawerActionPane(),

                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: cardItem(context, widget.history.history[index].address),

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
          ),
        ),
      ),
    );
  }

  // Widget historyItem(String name)
  // {
  //   return Builder(
  //     builder: (context){
  //       return GestureDetector(
  //         child: Card(
  //           child: Padding(
  //               padding: const EdgeInsets.all(9.0),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(bottom: 6),
  //                 child: Text(name, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
  //                     overflow:  TextOverflow.fade),
  //               )
  //           ),
  //         ),
  //         onTap: (){
  //           final slidable = Slidable.of(context);
  //           final isClosed = slidable.renderingMode == SlidableRenderingMode.none;
  //
  //           if(isClosed)
  //             slidable.open(actionType: SlideActionType.secondary);
  //
  //           else
  //             slidable.close();
  //         },
  //
  //       );
  //     },
  //   );
  //
  // }


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