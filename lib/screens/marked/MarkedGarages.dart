import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Model/LocationDetails.dart';
import '../../Shared/Marker.dart';
import '../../widgets/Appdrawer.dart';
import '../../widgets/NearbyPlaces.dart';

class markedGarages extends StatefulWidget {
  @required
  var currentLocation;
  @required
  List<LocationDetails> data;

  markedGarages({this.currentLocation, this.data});
  @override
  State<markedGarages> createState() => _markedGaragesState();
}

class _markedGaragesState extends State<markedGarages> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = addMarkers(widget.data);
    return SafeArea(
      child: Scaffold(
          key: _scaffoldState,
          drawer: Appdrawer(context),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 2 / 3,
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
                    child: Container(
                      child: Text(
                        "Nearby Garages",
                        style: TextStyle(
                            fontSize: 20,
                            //color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  (widget.data.length != 0)
                      ? Flexible(
                      child: NearbyPlaces(widget.data, widget.currentLocation,false))
                      : Align(

                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('\nNo nearby places with vacant spots found',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 19, left: 16, right: 25, bottom: 25),
                  child: FloatingActionButton(
                    heroTag: 'side-menu',
                    backgroundColor: Colors.blueGrey,
                    mini: true,
                    child: const Icon(Icons.menu, color: Colors.white),
                    onPressed: ()  {
                      _scaffoldState.currentState.openDrawer();
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
