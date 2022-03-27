import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/widgets/GoogleSearch.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:provider/provider.dart';

import 'marked/MarkedPlaces.dart';


class search extends StatefulWidget{
  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {


  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    var location = currentLocation;


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
                    initialCameraPosition: (currentLocation != null) ? (CameraPosition(target:
                    LatLng(location.latitude, location.longitude), zoom: 20.0))
                    : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 18.0)),

                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    rotateGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    padding: EdgeInsets.only(top: 470.0,),

                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GoogleSearch(),
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
