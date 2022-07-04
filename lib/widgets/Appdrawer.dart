import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/side_menu_pages/bookmarksPage.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:provider/provider.dart';

import '../Model/DBModels/Bookmark.dart';
import '../Network/API/BookMarkes.dart';
import '../services/API/APIManager.dart';

Drawer Appdrawer(context) {
  String driverID;

  bool isLight = true;
  AppProvider provider;
  provider = Provider.of<AppProvider>(context);

  return Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    child: Column(
      children: <Widget>[
        DrawerHeader(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text("Nadah Khaled",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("nadahkhaledd@gmail.com",
                    style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                PopupMenuButton(
                    icon: Icon(Icons.arrow_drop_down_outlined,
                        color: Colors.blueGrey),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            title: Text("Edit info"),
                          ))
                        ])
              ],
            )
          ],
        )),

        Container(
          child: ListTile(
            leading: Icon(Icons.home_filled, color: Colors.blueGrey),
            title: Text('Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
            autofocus: true,
            onTap: () {

            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blueGrey),
          title: Text('Bookmarks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: () async {
            print(provider.currentUser.token);
            List<Bookmark> bookmarks = await getBookmarks("UtxbOluLTzMTooCY01XD0vqAAUf2",  provider.currentUser.token);
            navigateTo(context, bookmarksPage(bookmarks));
          },
        ),

        ListTile(
          leading: Icon(isLight ? Icons.light_mode : Icons.dark_mode, color: Colors.blueGrey),
          title: Text('Theme', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: ()  {

          },
        ),

        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.6),
          child: Column(
            children: [
              Divider(
                height: 1,
                thickness: 2,
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.blueGrey),
                title: Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                onTap: ()  {

                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
