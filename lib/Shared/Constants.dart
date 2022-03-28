import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import '../Model/DateTime.dart';
import '../Model/LocationDetails.dart';
import '../services/directions_repository.dart';

Set<Marker> addMarkers( List<LocationDetails> loc )
{
  final Set<Marker> markers = new Set();
  for(int i=0;i<loc.length;i++)
  {
    markers.add(Marker( //add first marker
      markerId: MarkerId(loc[i].name),
      position: LatLng(loc[i].location.lat, loc[i].location.lng),
      icon: BitmapDescriptor.defaultMarker,
//Icon for Marker
    ));
  }
  return markers;
}
 Future<Set<DT>>  getDistanceAndTime(
    List<LocationDetails> loc,
    Location home,
    ) async {
  final Set<DT> dt=new Set();
  for(int i=0;i<loc.length;i++)
    {
      final directions = await DirectionsRepository()
          .getDirections(origin: LatLng(home.lat, home.lng), destination:LatLng(loc[i].location.lat, loc[i].location.lng) );
    DT dtt=new DT (directions.totalDistance,directions.totalDuration);
    dt.add(dtt);
    }
  return dt;
}


Future <String> getDistance(
    Location loc,
    Location home,
    ) async {
  /*final Set<DT> dt=new Set();
  for(int i=0;i<loc.length;i++)
  {*/
    final directions = await DirectionsRepository()
        .getDirections(origin: LatLng(home.lat, home.lng), destination:LatLng(loc.lat, loc.lng) );
    DT dtt=new DT (directions.totalDistance,directions.totalDuration);
    //dt.add(dtt);
  //}
  return directions.totalDistance;
}