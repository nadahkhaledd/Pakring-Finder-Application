import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Network/API/Recents.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/Shared/Constants.dart';
import 'package:park_locator/screens/side_menu_pages/EditInfoPage.dart';
import 'package:park_locator/screens/side_menu_pages/bookmarksPage.dart';
import 'package:park_locator/screens/side_menu_pages/historyPage.dart';

import 'package:park_locator/screens/user/login.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/DBModels/Bookmark.dart';
import '../Model/DBModels/Recent.dart';
import '../Network/API/Bookmarks.dart';
import '../screens/Home.dart';

Drawer Appdrawer(context) {

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
          decoration: BoxDecoration(
            color: Colors.blueGrey
          ),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Text(provider.currentUser. name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(provider.currentUser.email,
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                PopupMenuButton(
                    icon: Icon(Icons.arrow_drop_down_outlined,
                        color: Colors.white),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                              child: ListTile(
                            title: Text("Edit info"),
                                onTap: (){
                                  navigateTo(context, EditInfoPage(provider.currentUser.name,provider.currentUser.email,provider.currentUser.number));
                                },
                          ))
                        ])
              ],
            )
          ],
        )),

        ListTile(
          leading: Icon(Icons.home_filled, color: Colors.blueGrey),
          title: Text('Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          autofocus: true,
          onTap: () {
            navigateAndFinish(context, Home());
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blueGrey),
          title: Text('Bookmarks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: () async {
            List<Bookmark> bookmarks = await getBookmarks(provider.currentUser.id,  provider.currentUser.token);
            navigateTo(context, bookmarksPage(bookmarks));
          },
        ),

        ListTile(
          leading: Icon(Icons.history, color: Colors.blueGrey),
          title: Text('Recent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: ()  async{
            Recent history = await getHistory(provider.currentUser.id, provider.currentUser.token);
            navigateTo(context, historyPage(history));
          },
        ),


        Flexible(
          child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.7),
              child: Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 2,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.blueGrey),
                    title: Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    onTap: ()  async{
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove(Constants.ACCESS_TOKEN);
                      prefs.remove(Constants.ACCESS_ID);
                      navigateAndFinish(context, login());
                    },
                  ),
                ],
              ),
            ),
        )
      ],
    ),
  );
}
