import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import '../Model/DBModels/Bookmark.dart';
import '../Model/DBModels/Camera.dart';
import '../Model/Location.dart';
import '../Model/LocationDetails.dart';
import '../Model/UserData.dart';
import '../Network/API/Bookmarks.dart';
import '../Network/API/Garages.dart';
import '../Network/API/StreetAPI.dart';
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

Future<List<LocationDetails>> getFinalData(List snaps,  List<Camera> nearest,LatLng current, String token) async {
  List newSnaps = [];
  List<LocationDetails> finalData = [];
  if (snaps.length != 0) {
    for (int i = 0; i < snaps.length; i++) {

      String url = snaps[i].data["path"];
      String cap = (snaps[i].data["capacity"]).toString();
      String spots = await getStreetData(url:url, capacity: cap,token: token);
      if (spots != null) {
        if (int.parse(spots) > 0) {
          List<Camera> x = await getFData(snaps[i].data["cameraID"], nearest);
          LatLng loc = x[0].getLocation;
          String distance = await getDistance(loc, current);
          String time = await getTime(loc,current);
          LocationDetails details = new LocationDetails(
              cameraID: snaps[i].data["cameraID"],
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
Future<List> getFinalDataGarages2(List nearest,LatLng current) async {
  List<LocationDetails> nearest2=[];
  List cameras=[];
  bool found=false;
  for (int i=0;i<nearest.length;i++)
    {
      for(int j=0;j<nearest[i]['cameras'].length;j++)
        {
          if(nearest[i]['cameras'][j]['spot']>0)
            {
              found=true;
              cameras.add({'cameraID': nearest[i]['cameras'][j]['cameraID'], 'cameraAddress': nearest[i]['cameras'][j]['cameraAddress'],'spot':nearest[i]['cameras'][j]['spot']});
            }

        }
      if (found==true)
        {
          String distance = await getDistance(nearest[i]['location'], current);
          String time = await getTime(nearest[i]['location'],current);
          LocationDetails details = new LocationDetails(
           cameraIDs: cameras,
           garageID:nearest[i]['garageID'],
           name:  nearest[i]['garageAddress'],
           distance: distance.toString(),
           time: time.toString(),
           location: nearest[i]['location']
          );
          nearest2.add(details);
        }
    }
  return nearest2;
}

Future<List> getFinalDataGarages(List nearest,List GarageSnaps,LatLng current, String token) async {
  List<LocationDetails> finalData = [];
  List garages=[];
  if (GarageSnaps.length != 0) {
    for (int i = 0; i < GarageSnaps.length; i++) {
      String url = GarageSnaps[i].data["path"];
      String cap = (GarageSnaps[i].data["capacity"]).toString();
      String spots = await getStreetData(url: url, capacity: cap, token: token);

      if (spots != null) {
        if (int.parse(spots) > 0) {
          for (int j=0;j<nearest.length;j++)
            {
              for (int k = 0; k < nearest[j]['cameras'].length; k++)
                {
                  if (GarageSnaps[i].data["garageCameraID"]==nearest[j]['cameras'][k]['cameraID'])
                    {
                      nearest[j]['cameras'][k]['spot']=int.parse(spots);
                    }
                }

            }
        }
      }

    }
  }
  return nearest;
}


Future<List> getFData(String id, List<Camera> near) async{
  List<Camera> x = [];
  for (int i = 0; i < near.length; i++)
    if (id == near[i].getID) {
      x.add(near[i]);
      return x;
    }
}

Future<List> setGarages(String id, List near) async{
  List x = [];
  for (int i = 0; i < near.length; i++) {
    print("-------------------------");
    print(id);
    print(near[i]['cameras'].length);
    for (int j = 0; j < near[i]['cameras'].length; j++) {
      print(id);
      if (id == near[i]['cameras'][j]['cameraID']) {
        print(near[i]['cameras'][j]['cameraID']);
        x.add(near[i]['cameras'][j]['cameraID']);
        return x;
      }
    }
  }


}