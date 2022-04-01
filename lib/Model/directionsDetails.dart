import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/services/directions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/utils/google_search/latlng.dart' as lat;




class directionsDetails
{
      //final mall_egypt=LatLng(29.976253314162836, 31.01812820881605);
      final LatLng home;
      final LatLng work;
      var myLocation_name="";
      var destination_name="";
      var duration="";
      var distance="";
      PolylinePoints polylinePoints;
      Map<PolylineId, Polyline> polylines = {};
      List<LatLng> polylineCoordinates = [];
      directionsDetails(this.home, this.work){
            _createPolylines( home.latitude, home.longitude, work.latitude, work.longitude);
      }
      String getMyLocation_name()
      {
          return myLocation_name;
      }
      String getDestination_name()
      {
        return destination_name;
      }
      String getduration()
      {
        return duration;
      }
      String getDistance()
      {
        return distance;
      }
      Map<PolylineId, Polyline> getPolylines()
      {
            return polylines;
      }
      //LatLng x = new LatLng(latitude, longitude);

      _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
      final directions = await DirectionsRepository()
          .getDirections(origin: home, destination: work);
      myLocation_name=directions.source;
      destination_name=directions.target;
      duration=directions.totalDuration;
      distance=directions.totalDistance;
      polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w", // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
      );

      if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      }

      PolylineId id = PolylineId('poly');
      Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
      );
      polylines[id] = polyline;

      }

}