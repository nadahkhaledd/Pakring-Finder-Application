import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/directionsDetails.dart';

import 'package:park_locator/services/directionsModel.dart';
import 'package:park_locator/services/directions_repository.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:park_locator/widgets/searchBar.dart';
import 'package:park_locator/widgets/d_widgets/time.dart';
import 'package:provider/provider.dart';
import 'package:park_locator/Model/directionsDetails.dart';


class direction_screen extends StatefulWidget{
  @override
  _searchState createState() => _searchState();



}

class _searchState extends State<direction_screen> {
  var currentLocation;
  var mall_egypt=LatLng(29.976253314162836, 31.01812820881605);
  var home=LatLng(29.96452052837998, 31.102888360619545);
  directionsDetails info;
  @override
  void initState() {
    super.initState();
    info = new directionsDetails(LatLng(29.96452052837998, 31.102888360619545), LatLng(29.976253314162836, 31.01812820881605));

  }



  @override
  Widget build(BuildContext context) {

    final currentLocation = Provider.of<Position>(context);

    //_createPolylines(home.latitude,home.longitude,mall_egypt.latitude,mall_egypt.longitude);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width,
            child: from_to(source: info.myLocation_name,target: info.destination_name,),
          ),
          Container(
            //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
            height: MediaQuery.of(context).size.height*0.61,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: (currentLocation != null) ? (CameraPosition(target:
              LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 20.0,))
                  : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 9.0)),

              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              //myLocationEnabled: true,
              padding: EdgeInsets.only(top: 200.0,),
              polylines: Set<Polyline>.of(info.getPolylines().values),


            ),
          ),
          Container(
            //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
              height: MediaQuery.of(context).size.height*0.16,
              width: MediaQuery.of(context).size.width,
              child: time(totalDistance: info.distance,totalDuration: info.duration)),

        ],
      ),
    );

  }

}