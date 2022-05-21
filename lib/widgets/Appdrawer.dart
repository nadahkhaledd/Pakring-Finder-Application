
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/screens/side_menu_pages/bookmarksPage.dart';

Drawer Appdrawer(context) {

  return Drawer(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20)),
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
                child: Text("Nadah Khaled", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("nadahkhaledd@gmail.com", style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                  PopupMenuButton(
                    icon: Icon(Icons.arrow_drop_down_outlined, color: Colors.blueGrey),
                      itemBuilder: (context)=>
                  [
                    PopupMenuItem(
                        child: ListTile(
                          title: Text("Edit info"),
                        )
                    )
                  ]
                  )

                ],
              )
            ],
          )
        ),

        ListTile(
          leading: Icon(Icons.home_filled, color: Colors.blueGrey),
          title: Text('Home', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: () {
          },
        ),
        ListTile(
          leading: Icon(Icons.bookmark, color: Colors.blueGrey),
          title: Text('Bookmarks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          onTap: () {
            navigateTo(context, bookmarksPage());
          },
        ),
        ListTile(
          leading: Icon(Icons.access_time_outlined, color: Colors.blueGrey),
          title: Text('Recent', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        ),
        ListTile(
          leading: Icon(Icons.light_mode, color: Colors.blueGrey),
          title: Text('Theme', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
        ),

        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/3),
          child: Column(
            children: [
              Divider(
                height: 1,
                thickness: 2,
              ),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.blueGrey),
                title: Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
