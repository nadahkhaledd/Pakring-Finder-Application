import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import 'package:park_locator/Model/directionsDetails.dart';

import 'package:park_locator/services/directionsModel.dart';
import 'package:park_locator/services/directions_repository.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:park_locator/widgets/d_widgets/time.dart';
import 'package:provider/provider.dart';
import 'package:park_locator/Model/directionsDetails.dart';

import '../Shared/Marker.dart';


class direction_screen extends StatefulWidget{
  @required var currentLocation;
  @required directionsDetails info;

  direction_screen({this.currentLocation,this.info});


  @override
  State<direction_screen> createState() => _searchState();


}

class _searchState extends State<direction_screen> {


  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = addMarkers2(widget.currentLocation,widget.info.getDestination());

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width,
           // color: Colors.black,
            child: from_to(source: widget.info.myLocation_name,target: widget.info.destination_name,),
          ),
          Container(
            //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
            height: MediaQuery.of(context).size.height*0.61,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: (widget.currentLocation != null) ? (CameraPosition(target:
              LatLng(widget.currentLocation.latitude,widget.currentLocation.longitude), zoom: 15.0,))
                  : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 13.0)),

              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              //myLocationEnabled: true,
              padding: EdgeInsets.only(top: 200.0,),
              polylines: Set<Polyline>.of(widget.info.getPolylines().values),
              markers:markers ,


            ),
          ),
          Container(
            //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
              height: MediaQuery.of(context).size.height*0.16,
              width: MediaQuery.of(context).size.width,
              child: time(totalDistance: widget.info.distance,totalDuration: widget.info.duration)),

        ],
      ),
    );

  }

}