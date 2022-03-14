import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/widgets/searchBar.dart';
import 'package:provider/provider.dart';


class search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*2/3,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: (currentLocation != null) ? (CameraPosition(target:
                    LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 20.0))
                        : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 9.0)),

                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    rotateGesturesEnabled: true,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    padding: EdgeInsets.only(top: 270.0,),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: searchBar(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
