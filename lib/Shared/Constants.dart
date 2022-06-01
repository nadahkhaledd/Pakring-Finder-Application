import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import '../Model/DBModels/Bookmark.dart';
import '../Model/DBModels/Camera.dart';
import '../Model/LocationDetails.dart';
import '../Network/APIS.dart';
import '../services/API/APIManager.dart';
import '../services/DistanceMatrix.dart';
import '../services/directions_repository.dart';


var location = LatLng(30.0313, 31.2107);   ///default

Future <String> getDistance(LatLng destination, LatLng current) async {
    final directions = await DirectionsRepository()
        .getDirections(origin:current,
        destination:destination );
    return directions.totalDistance;
}

Future <String> getTime(LatLng destination, LatLng current) async {
  if(current != null)
    {
      final directions = await DirectionsRepository()
          .getDirections(origin:current,
          destination:LatLng(destination.latitude, destination.longitude) );
      return directions.totalDuration;
    }
}

void setSearchLocation (LatLng source) async
{
  location = source;
}

LatLng getSearchLocation ()
{
  return location;
}

bool isThereLocation ()
{
  return location!=null;
}


List getCamerasIDs(List<Camera> cameras)
{
  List IDs = [];
  cameras.forEach((element) {
    IDs.add(element.getID);
  });
  return IDs;
}

List getGarageCamerasIDs(List garages)
{
  List IDs = [];
  for(var garage in garages)
    {
      for(var camera in garage['cameras'])
        IDs.add(camera['cameraID']);
    }
  return IDs;
}

Future<Map> findIfBookmark(String userid, LatLng destination)
async {
  String bookmarkID = '0';
  bool yes;
  List<Bookmark> bookmarks = await getBookmarks("UtxbOluLTzMTooCY01XD0vqAAUf2");
  bookmarks.forEach((element) {

    if( element.location.lat == destination.latitude &&
        element.location.long == destination.longitude)
    {
      bookmarkID = element.id;
      yes =true;
    }
    else
      {
        yes = false;
      }

  }
  );
  return {'id': bookmarkID, 'yes': yes};
}


Future<List<LocationDetails>> getFinalData(List snaps,  List<Camera> nearest,LatLng current) async {
  List newSnaps = [];
  List<LocationDetails> finalData = [];
  if (snaps.length != 0) {
    for (int i = 0; i < snaps.length; i++) {
      String url = snaps[i]["Path"];
      String cap = (snaps[i]["Capacity"]).toString();
      String spots = await getApiData(url: url, capacity: cap);
      if (spots != null) {
        if (int.parse(spots) > 0) {
          List<Camera> x = await getFData(snaps[i]["Camera_ID"], nearest);
          LatLng loc = x[0].getLocation;
          String distance = await getDistance(loc, current);

          String time = await getTime(loc,current);
          LocationDetails details = new LocationDetails(
              cameraID: snaps[i]["Camera_ID"],
              spots: spots.toString(),
              name: x[0].getAddress.toString(),
              distance: distance.toString(),
              time: time.toString(),
              location: loc);
          finalData.add(details);
        }
      }
    }
  }
  return finalData;
}



Future<List> getFData(String id, List<Camera> near) async{
  List<Camera> x = [];
  for (int i = 0; i < near.length; i++)
    if (id == near[i].getID) {
      x.add(near[i]);
      return x;
    }
}

