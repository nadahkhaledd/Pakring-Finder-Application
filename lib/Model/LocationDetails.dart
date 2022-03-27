import 'package:flutter/cupertino.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/services/geoLocator.dart';

class LocationDetails
{
 @required final String capacity;
  final String name;
  final double distance;
  final String time;
  final Location location;

  LocationDetails(this.capacity, this.name, this.distance, this.time, this.location);

}



List <LocationDetails> locs=[
 LocationDetails("2", "Mohandsen", 5.5, "7", Location(lat:30.0480,lng:31.1997 )),
 LocationDetails("3", "Dokki", 5.5, "8", Location(lat:30.0395,lng: 31.2025 )),
 LocationDetails("3", "Agouza", 5.5, "8", Location(lat:30.0566,lng: 31.1968 )),
];

