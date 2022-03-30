import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import '../Model/DateTime.dart';
import '../Model/LocationDetails.dart';
import '../services/directions_repository.dart';

List<DT> dt= [];
void getDistanceAndTime(
    List<LocationDetails> loc,
    ) async {

  for(int i=0;i<loc.length;i++)
  {
    final directions = await DirectionsRepository()
        .getDirections(origin: LatLng(30.0313, 31.2107),
        destination:LatLng(loc[i].location.lat, loc[i].location.lng) );
    DT dtt=new DT (directions.totalDistance,directions.totalDuration);
    dt.add(dtt);
  }
 // emit(parkingDTSates());
 // return dt;
}

//final List<DT> dt= [];
/*
void getDistanceAndTime(
    List<LocationDetails> loc,
    Location home,
    ) async {
  for(int i=0;i<loc.length;i++)
  {
    final directions = await DirectionsRepository()
        .getDirections(origin: LatLng(home.lat, home.lng), destination:LatLng(loc[i].location.lat, loc[i].location.lng) );
    DT dtt=new DT (directions.totalDistance,directions.totalDuration);
    dt.add(dtt);
  }
}*/