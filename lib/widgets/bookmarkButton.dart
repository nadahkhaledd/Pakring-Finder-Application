import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/Location.dart';

import '../Model/UserData.dart';
import '../Network/API/Bookmarks.dart';

class bookmarkButton extends StatefulWidget
{
  bool isBookmark;
  String bookmarkID;
  LatLng destination;
  String destinationName;
  userData user;

  bookmarkButton(context, this.isBookmark, this.bookmarkID, this.destination, this.destinationName, this.user);

  @override
  State<bookmarkButton> createState() => _bookmarkButtonState();
}

class _bookmarkButtonState extends State<bookmarkButton> {
  bool bookmarkState;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    bookmarkState = widget.isBookmark;
    iconColor =  bookmarkState? Colors.yellow: Colors.white;
    return FloatingActionButton
      (
        heroTag: 'bookmark',
        backgroundColor: Colors.blueGrey,
        mini: true,
        shape: BeveledRectangleBorder(),
        child: Icon(Icons.bookmark, color: iconColor,),
        onPressed: ()
        async {
          String message;
          if(bookmarkState)
          {
            var response = await deleteBookmark(widget.bookmarkID, widget.user.token);
            if(response == 200)
            {
              setState(() {
                iconColor = Colors.blueGrey;
                bookmarkState = false;
                message = "deleted from bookmarks";
              });
            }
          }
          else
          {
            var lat = widget.destination.latitude;
            var long = widget.destination.longitude;
            Bookmark bookmark = new Bookmark(name: widget.destinationName, driverID: widget.user.id,
                location: Location(lat: lat, long: long),
                locationURL: "http://www.google.com/maps/place/$lat,$long");
            var response = await addBookmark(bookmark, widget.user.token);
            if (response == 200)
            {
              setState(() {
                iconColor = Colors.yellow;
                bookmarkState = true;
                message = "added to bookmarks";
              });

            }
          }
          final snackBar = SnackBar(
              content:  Text(message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    );
  }

  // Future<void> _toggleBookmark()
  // async {
  //   String message;
  //     if(bookmarkState)
  //     {
  //       var response = await deleteBookmark(widget.bookmarkID, widget.user.token);
  //       if(response == 200)
  //       {
  //         setState(() {
  //           iconColor = Colors.blueGrey;
  //           bookmarkState = false;
  //           message = "deleted from bookmarks";
  //         });
  //       }
  //     }
  //     else
  //     {
  //       var lat = widget.destination.latitude;
  //       var long = widget.destination.longitude;
  //       Bookmark bookmark = new Bookmark(name: widget.destinationName, driverID: widget.user.id,
  //           location: Location(lat: lat, long: long),
  //           locationURL: "http://www.google.com/maps/place/$lat,$long");
  //       var response = await addBookmark(bookmark, widget.user.token);
  //       if (response == 200)
  //       {
  //         setState(() {
  //           iconColor = Colors.yellow;
  //           bookmarkState = true;
  //           message = "added to bookmarks";
  //         });
  //
  //       }
  //     }
  //   final snackBar = SnackBar(
  //       content:  Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }
}

