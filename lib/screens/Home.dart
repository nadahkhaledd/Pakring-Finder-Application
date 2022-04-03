import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../Model/LocationDetails.dart';
import '../Network/APIS.dart';
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
  List nearestCameras, snaps, spots;

  void initState() {
    super.initState();
    getDistanceAndTime(locs);
  }

  void finalLocation() {
    if (isThereLocation()) {
      setState(() {
        _coordinates = getSearchLocation();
      });
    }
  }


  Future<void> setResults()
  async {
    finalLocation();
    nearestCameras = await getNearestCameras(_coordinates);
    List IDs = getCamerasIDs(nearestCameras);
    snaps = await getSnaps(IDs);
    spots = await GetSpots(snaps);
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);

    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
                GoogleMap(
                  initialCameraPosition:
                      (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0)),
                  compassEnabled: true,
                  mapToolbarEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  rotateGesturesEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  // padding: EdgeInsets.only(
                  //   top: MediaQuery.of(context).size.height * 1 / 3,
                  // ),
                  onMapCreated: (GoogleMapController controller) async {
                    _mapController = controller;
                  },
                ),


              Padding(
                padding: const EdgeInsets.all(10.0),
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
                    onPressed: ()
                    async {
                      if(_coordinates != null)
                        {
                          setState(() {
                            getDistanceAndTime(locs);
                          });

                          await setResults();
                          //navigateTo(context, MarkedPlaces(_coordinates));
                        }
                    },
                    isExtended: true,
                    label: Text("     Find     ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
        ],
      )),
    );
  }
}
