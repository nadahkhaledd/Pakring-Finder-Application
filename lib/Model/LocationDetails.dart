import 'package:flutter/cupertino.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/services/geoLocator.dart';

class LocationDetails
{
  final String capacity;
  final String name;
   String distance;
   String time;
  final Location location;

  LocationDetails(this.capacity, this.name, this.distance, this.time, this.location);

}



List <LocationDetails> locs=[
 LocationDetails("2", "Mohandsen", '0', "7", Location(lat:30.0480,lng:31.1997 )),
 LocationDetails("3", "Dokki", '0', "8", Location(lat:30.0395,lng: 31.2025 )),
 LocationDetails("3", "Agouza", '0', "8", Location(lat:30.0566,lng: 31.1968 )),
];

