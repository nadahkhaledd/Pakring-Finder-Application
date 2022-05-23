import 'package:flutter/material.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';

Container bookmarkItem(Bookmark bookmark)
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(bookmark.name, style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16), softWrap: true,),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.blueGrey),
          ),
        )

      ],
    )
  );
}