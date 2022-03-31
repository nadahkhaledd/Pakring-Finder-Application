import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/services/DB.dart';
import 'package:park_locator/test.dart';
import 'package:park_locator/widgets/GoogleSearch.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/utils/google_search/place.dart';

import '../Model/LocationDetails.dart';
import '../Shared/Constants.dart';
import 'marked/MarkedPlaces.dart';


class getLocation extends StatefulWidget{
  var currentLocation;
  getLocation(this.currentLocation);
  @override
  State<getLocation> createState() => _getLocationState();
}

class _getLocationState extends State<getLocation> {
  GoogleMapController _mapController;
  CameraPosition _position;
  var _coordinates;



  void initState() {
    super.initState();
    getDistanceAndTime(locs);
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void finalLocation()
  {
    if (isThereLocation())
      {
        setState(() {
          _coordinates = getSearchLocation();
        });
      }
  }

  setCurrent(var current)
  {
    if(current!= null)
      {
        setState(() {
          _position = CameraPosition(target: LatLng(current.latitude, current.longitude),zoom: 15.0);
        });

      }
    else
      {
        setState(() {
          _position = CameraPosition(target: LatLng(30.0313, 31.2107), zoom:15.0);
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    setCurrent(widget.currentLocation);
    _coordinates = _position.target;
    print('\n\ncurrent:' + _coordinates.latitude.toString() + ',' + _coordinates.longitude.toString());


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
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      padding: EdgeInsets.only(top: 160.0,),

                      onMapCreated: (GoogleMapController controller) async{
                        _mapController = controller;
                        print('\ncurrent before : ' + _coordinates.toString());
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
                            onPressed: ()
                              {
                                setState(() {
                                  getDistanceAndTime(locs);
                                });
                                finalLocation();
                                print('\nafter: ' + _coordinates.toString());
                                List nearest = getData(_coordinates);
                                navigateTo(context, MarkedPlaces(_coordinates));
                              },
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