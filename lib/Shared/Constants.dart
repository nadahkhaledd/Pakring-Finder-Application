import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import '../Model/DateTime.dart';
import '../Model/LocationDetails.dart';
import '../services/directions_repository.dart';




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