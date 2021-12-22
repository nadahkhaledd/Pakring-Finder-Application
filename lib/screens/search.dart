import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';


class search extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*2/3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: (currentLocation != null) ? (CameraPosition(target:
              LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 18.0))
              : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 9.0)),

              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          )
        ],
      ),
    );
  }

}
