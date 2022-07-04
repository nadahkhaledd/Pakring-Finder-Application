import 'package:flutter/material.dart';


ListTile bookmarkItem(String bookmarkName)
{
  return ListTile(
    title: Text(bookmarkName, style:
    TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
        overflow:  TextOverflow.fade),
    onTap: (){},
  );
}
