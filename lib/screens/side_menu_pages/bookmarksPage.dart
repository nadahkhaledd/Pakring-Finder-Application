import 'package:flutter/material.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/widgets/bookmarkItem.dart';

class bookmarksPage extends StatefulWidget
{
  List<Bookmark> bookmarks;
  bookmarksPage(this.bookmarks);

  @override
  State<bookmarksPage> createState() => _bookmarksPageState();
}

class _bookmarksPageState extends State<bookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          toolbarHeight: 70.0,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),
          backgroundColor: Colors.blueGrey,
          title: Text(" Bookmarks "),
          centerTitle: true,
        ),

        body: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 1, height: 1),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.bookmarks.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
                  child: bookmarkItem(context, widget.bookmarks[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}