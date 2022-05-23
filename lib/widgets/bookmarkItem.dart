import 'package:flutter/material.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/side_menu_pages/bookmarksPage.dart';

import '../services/API/APIManager.dart';

Container bookmarkItem(context, Bookmark bookmark)
{
  return Container(
    decoration: new BoxDecoration(
      border: Border.all(color: Colors.black26),
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(bookmark.name, style:
            TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
              overflow:  TextOverflow.fade),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () async {
              int code = await deleteBookmark(bookmark.id);
              if(code == 200)
              {
                List bookmarks = await getBookmarks(bookmark.driverID);
                navigateTo(context, bookmarksPage(bookmarks));
              }
              else
                print(code);
            },
          ),
        )

      ],
    )
  );
}

