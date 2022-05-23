import 'package:flutter/material.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/widgets/bookmarkItem.dart';

class bookmarksPage extends StatelessWidget
{
  List<Bookmark> bookmarks;
  bookmarksPage(this.bookmarks);

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

        body: ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(15, 6, 15, 6),
            child: bookmarkItem(bookmarks[index]),
          ),
        ),
      ),
    );
  }

}