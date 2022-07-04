import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/widgets/loadingIndicator.dart';

import '../Model/UserData.dart';
import '../Network/API/BookMarkes.dart';

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
    iconColor =  bookmarkState? Colors.yellow: Colors.blueGrey;
    return FloatingActionButton
      (
        heroTag: 'bookmark',
        backgroundColor: Colors.white,
        mini: true,
        shape: BeveledRectangleBorder(),
        child: Icon(Icons.bookmark, color: iconColor,),
        onPressed: ()
      async {
        await _toggleBookmark();
      },
    );
  }

  Future<void> _toggleBookmark()
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
        Bookmark bookmark = new Bookmark(name: widget.destinationName, driverID: widget.user.id,
            location: Location(lat: widget.destination.latitude, long: widget.destination.longitude));
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
}

