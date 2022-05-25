import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/widgets/loadingIndicator.dart';

FloatingActionButton bookmarkButton(context, bool isBookmark, String bookmarkID, LatLng destination, String destinationName)
{
  String userID="UtxbOluLTzMTooCY01XD0vqAAUf2";
  Color iconColor =  isBookmark? Colors.yellow: Colors.blueGrey;
  return FloatingActionButton(
    heroTag: 'bookmark',
    backgroundColor: Colors.white,
    mini: true,
    shape: BeveledRectangleBorder(),
    child: Icon(Icons.bookmark, color: iconColor,),

    onPressed: ()
    async {
      if(isBookmark)
        {
          deleteBookmark(bookmarkID);
          iconColor = Colors.blueGrey;
          loadingIndicator(context, "Bookmark deleted", false);
        }
      else
        {
          Bookmark bookmark = new Bookmark(name: destinationName, driverID: userID,
              location: Location(lat: destination.latitude, long: destination.longitude));
          print(bookmark.driverID);
          print(bookmark.name);
          var response = await addBookmark(bookmark);
          print(response);
          if (response == 200)
            {
              isBookmark = true;
              loadingIndicator(context, "Added to bookmarks", false);
            }

        }

    },

  );
}