import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/widgets/NearbyPlaces.dart';
import '../../Model/LocationDetails.dart';
import '../../Shared/Components.dart';
import '../../Shared/Marker.dart';
import '../direction_screen.dart';


class MarkedPlaces extends StatefulWidget {

  @required var currentLocation;
  @required List <LocationDetails> data;

  MarkedPlaces({this.currentLocation,this.data});


  @override
  State<MarkedPlaces> createState() => _MarkedPlacesState();
}

class _MarkedPlacesState extends State<MarkedPlaces> {

  Widget build(BuildContext context) {
    Set<Marker> markers = addMarkers(widget.data);

    return Scaffold(
        body: SafeArea(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 1.5 / 3,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  markers: markers,
                  initialCameraPosition: (widget.currentLocation != null)
                      ? (CameraPosition(
                          target: LatLng(widget.currentLocation.latitude,
                              widget.currentLocation.longitude),
                          zoom: 13))
                      : (CameraPosition(
                          target: LatLng(30.0313, 31.2107), zoom: 20.0)),
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  rotateGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  //myLocationEnabled: true,
                  // padding: EdgeInsets.only(
                  //   top: 270.0,
                  // ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Nearby Places",
                  style: TextStyle(
                      fontSize: 20,
                      //color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Flexible(child: NearbyPlaces(widget.data)),
            ],
            ),
        ));
  }
}
