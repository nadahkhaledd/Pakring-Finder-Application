import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:park_locator/widgets/bookmarkItem.dart';
import 'package:provider/provider.dart';

import '../../Model/UserData.dart';

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
                  actionPane: SlidableDrawerActionPane(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                    child: bookmarkItem(context, widget.bookmarks[index], provider.currentUser.token),
                  ),

                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Go to',
                      color: Colors.blueGrey,
                      icon: Icons.directions,
                      onTap: ()
                      {

                      },
                    )
                  ],

                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Share',
                      color: Colors.green,
                      icon: Icons.share,
                      onTap: ()
                      {

                      },
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: ()
                      {

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
}