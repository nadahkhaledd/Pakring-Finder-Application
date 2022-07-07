import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import '../Model/DBModels/Bookmark.dart';
import '../Model/DBModels/Camera.dart';
import '../Model/LocationDetails.dart';
import '../Model/UserData.dart';
import '../Network/API/BookMarks.dart';
import '../Network/API/StreetAPI.dart';
import '../services/API/APIManager.dart';
import '../services/DistanceMatrix.dart';
import '../services/directions_repository.dart';


LatLng location;   ///default

Future <String> getDistance(LatLng destination, LatLng current) async {
    final directions = await DirectionsRepository()
        .getDirections(origin:current,
        destination:destination );
    return directions.totalDistance;
}

Future <String> getTime(LatLng destination, LatLng current) async {
  if(current != null && destination != null)
    {
      DirectionsRepository directionRepo = new DirectionsRepository();
      final directions = await directionRepo.getDirections(origin:current,
          destination:destination);
      return directions.totalDuration;
    }
}

enum SlidableAction{delete, headTo, share}

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

Future<Map> findIfBookmark(LatLng destination, userData user)
async {
  String bookmarkID = '0';
  bool yes = false;
  List<Bookmark> bookmarks = await getBookmarks( user.id,user.token);
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


Future<List<LocationDetails>> getFinalData(List snaps,  List<Camera> nearest,LatLng current, String token) async {
  List newSnaps = [];
  List<LocationDetails> finalData = [];
  if (snaps.length != 0) {
    for (int i = 0; i < snaps.length; i++) {
      String url = snaps[i]["Path"];
      String cap = (snaps[i]["Capacity"]).toString();
      String spots = await getStreetData(url:url, capacity: cap,token: token);
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
Future<List<LocationDetails>> getFinalDataGarages(List GarageSnaps,LatLng current, String token) async {
  List<LocationDetails> finalData = [];
  if (GarageSnaps.length != 0) {
    for (int i = 0; i < GarageSnaps.length; i++) {
      String url = GarageSnaps[i]["Path"];
      String cap = (GarageSnaps[i]["Capacity"]).toString();
      String spots = await getStreetData(url: url, capacity: cap, token: token);
      if (spots != null) {
        if (int.parse(spots) > 0) {

          LatLng loc = await getGarageCamerasLocation(GarageSnaps[i]["GarageCameraID"], token);
          String name= await getGarageCamerasName(GarageSnaps[i]["GarageCameraID"], token);
          String distance = await getDistance(loc, current);

          String time = await getTime(loc,current);
          LocationDetails details = new LocationDetails(
              cameraID: GarageSnaps[i]["GarageCameraID"],
              spots: spots.toString(),
              name: name.toString(),
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

