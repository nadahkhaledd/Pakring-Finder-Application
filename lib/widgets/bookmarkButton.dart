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
        onPressed: _toggleBookmark,
    );
  }

  Future<void> _toggleBookmark()
  async {
    print('in the method');

      if(bookmarkState)
      {
        print('deleted');
        var response = await deleteBookmark(widget.bookmarkID, widget.user.token);
        if(response == 200)
        {
          iconColor = Colors.blueGrey;
          bookmarkState = false;
        }
      }
      else
      {
        Bookmark bookmark = new Bookmark(name: widget.destinationName, driverID: widget.user.id,
            location: Location(lat: widget.destination.latitude, long: widget.destination.longitude));
        var response = await addBookmark(bookmark, widget.user.token);
        if (response == 200)
        {
          iconColor = Colors.yellow;
          bookmarkState = true;
        }
      }


  }
}

