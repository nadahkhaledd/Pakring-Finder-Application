import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/widgets/GoogleSearch.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/utils/google_search/place.dart';

import 'marked/MarkedPlaces.dart';


class search extends StatefulWidget{
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {

  GoogleMapController _mapController;


  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    CameraPosition _position = (currentLocation != null) ?  (CameraPosition(target:
    LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 20.0))
        : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 18.0));


    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [

                  Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: _position,
                    compassEnabled: true,
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    rotateGesturesEnabled: true,
                    trafficEnabled: false,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    padding: EdgeInsets.only(top: 470.0,),

                    onMapCreated: (GoogleMapController controller) async{
                        _mapController = controller;
                    },

                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GoogleSearch(_mapController),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton.extended(
                            onPressed: (){navigateTo(context, MarkedPlaces());},
                            isExtended: true,
                            label: Text("    Find    ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
