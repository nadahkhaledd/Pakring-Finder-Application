import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/services/geoLocator.dart';

class LocationDetails
{
   String spots;
   String name;
   String distance;
   String time;
   String cameraID;
   LatLng location;

  LocationDetails({this.spots, this.name, this.distance, this.time,this.cameraID, this.location});

}


/*
List <LocationDetails> locs=[
 LocationDetails("2", "Mohandsen", '0', "7", Location(lat:30.0480,lng:31.1997 )),
 LocationDetails("3", "Dokki", '0', "8", Location(lat:30.0395,lng: 31.2025 )),
 LocationDetails("3", "Agouza", '0', "8", Location(lat:30.0566,lng: 31.1968 )),
];

*/