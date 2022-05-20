import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/widgets/loadingIndicator.dart';
import 'package:provider/provider.dart';

import '../Model/LocationDetails.dart';
import '../Shared/Components.dart';
import '../Shared/Constants.dart';
import '../services/DB.dart';
import '../widgets/GoogleSearch.dart';
import 'marked/MarkedPlaces.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController _mapController;
  LatLng _coordinates;
  List snaps, nearestCameras;
  List<LocationDetails> data = [];
  bool isLoading = false;

  void finalLocation() {
    if (isThereLocation()) {
      setState(() {
        _coordinates = getSearchLocation();
      });
    }
  }

  Future<void> setResults() async {
    setState(() {
      isLoading = true;
    });
    nearestCameras = await getNearestCameras(_coordinates);
    List IDs = getCamerasIDs(nearestCameras);
    snaps = await getSnaps(IDs);
    data = await getFinalData(snaps, nearestCameras, _coordinates);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);

    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: (currentLocation == null)
                ? (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0))
                : (CameraPosition(
                    target: LatLng(
                        currentLocation.latitude, currentLocation.longitude),
                    zoom: 16.0)),
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              _mapController = controller;
            },
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GoogleSearch(_mapController),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(top: 120, left: 10, right: 10),
            child: FloatingActionButton(
              heroTag: 'location',
              backgroundColor: Colors.white,
              mini: true,
              shape: BeveledRectangleBorder(),
              child:
                  const Icon(Icons.location_searching, color: Colors.black54),
              onPressed: () {
                _mapController.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 16.0)));

                setState(() {
                  _coordinates = LatLng(
                      currentLocation.latitude, currentLocation.longitude);
                  setSearchLocation(_coordinates);
                });
              },
            ),
          ),

          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton.extended(
                heroTag: 'run',
                onPressed: () async {
                  finalLocation();
                  if (_coordinates != null) {
                    await setResults();
                    navigateTo(
                        context,
                        MarkedPlaces(
                          currentLocation: _coordinates,
                          data: data,
                        ));
                  }
                },
                isExtended: true,
                label: Text(
                  "  Find  ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          ),

          Center( child: isLoading == true ?
            loadingIndicator(context, "Processing Data... ")
                : Center(),
          )
        ],
      )),
    );
  }
}
