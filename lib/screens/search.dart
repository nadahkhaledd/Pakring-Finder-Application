import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/services/directions.dart';
import 'package:park_locator/services/directionsModel.dart';
import 'package:park_locator/widgets/searchBar.dart';
import 'package:provider/provider.dart';


class search extends StatefulWidget{
  @override
  _searchState createState() => _searchState();


}

class _searchState extends State<search> {
  Marker _destination=Marker(markerId: MarkerId("2"),position: LatLng(30.018239902275475, 31.214682161808014));
  var currentLocation;
  Directions _info;
  void _addLoc(LatLng pos) async {
    print("ahh");
    setState(() {
      print(_destination.position);
      _destination = Marker(
        markerId:  MarkerId('destination'),
        position: pos,
      );
      print(_destination.position);
    });
     final directions = await DirectionsRepository()
          .getDirections(origin: LatLng(currentLocation.latitude, currentLocation.longitude), destination: pos);

      setState(() {
        _info= directions;
      });
      print(directions.polylinePoints);
  }
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

                  markers:{ _destination},

                  polylines: {
                    if(_info != null)
                      Polyline(
                        polylineId: PolylineId('overview_polyline'),
                        color: Colors.blue,
                        width: 5,
                        points: _info.polylinePoints
                            .map((e) => LatLng(e.latitude, e.longitude))
                            .toList(),
                      ),
                  },
                  onLongPress: _addLoc,

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

