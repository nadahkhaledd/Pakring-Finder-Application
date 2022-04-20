import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Model/LocationDetails.dart';
import '../Network/APIS.dart';
import '../services/directions_repository.dart';


var location = LatLng(30.0313, 31.2107);   ///default

Future <String> getDistance(LatLng destination, LatLng current) async {
    final directions = await DirectionsRepository()
        .getDirections(origin:current,
        destination:LatLng(destination.latitude, destination.longitude) );
    return directions.totalDistance;
}

Future <String> getTime(LatLng destination, LatLng current) async {
  final directions = await DirectionsRepository()
      .getDirections(origin:current,
      destination:LatLng(destination.latitude, destination.longitude) );
  return directions.totalDuration;
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


List getCamerasIDs(List cameras)
{
  List IDs = [];
  cameras.forEach((element) {
    IDs.add(element['id']);
  });

  return IDs;
}


Future<List<LocationDetails>> getFinalData(List snaps,  List nearest,LatLng current) async {
  List newSnaps = [];
  List<LocationDetails> finalData = [];
  if (snaps.length != 0) {
    for (int i = 0; i < snaps.length; i++) {
      String url = snaps[i]["Path"];
      String cap = (snaps[i]["Capacity"]).toString();
      String spots = await getApiData(url: url, capacity: cap);
      if (spots != null) {
        if (int.parse(spots) > 0) {
          List x = await getFData(snaps[i]["Camera_ID"], nearest);
          LatLng loc = x[0]['location'];
          String distance = await getDistance(loc,current);

          String time = await getTime(loc,current);
          LocationDetails details = new LocationDetails(
              spots: spots.toString(),
              name: x[0]['address'].toString(),
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



Future<List> getFData(int id, List near) async{
  List x = [];
  for (int i = 0; i < near.length; i++)
    if (id == near[i]['id']) {
      x.add(near[i]);
      return x;
    }
}
