import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:park_locator/widgets/loadingIndicator.dart';
import 'package:provider/provider.dart';

import '../Model/LocationDetails.dart';
import '../Shared/Components.dart';
import '../Shared/Functions.dart';
import '../services/DB.dart';
import '../services/appprovider.dart';
import '../widgets/GoogleSearch.dart';
import 'marked/MarkedGarages.dart';
import 'marked/MarkedPlaces.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //GoogleMapController _mapController;
  Position currentLocation;
  AppProvider provider;
  String currentUserToken;
  LatLng _coordinates = LatLng(30.0313, 31.2107);
  List snaps, nearestCameras, nearestGarages,GarageSnaps;
  List<LocationDetails> data = [];
  bool isLoading = false;

  void finalLocation() {
    if (isThereLocation()) {
      setState(() {
        _coordinates = getSearchLocation();
      });
    }
  }

  Future<void> setResultsGarage() async {
    setState(() {
      isLoading = true;
    });
    nearestGarages = await getGarageCameras(_coordinates, currentUserToken);
    List GaragesCamerasIDs = getGarageCamerasIDs(nearestGarages);
    GarageSnaps = await getSnapsgarage(GaragesCamerasIDs);
    data = await getFinalDataGarages(GarageSnaps, _coordinates, currentUserToken);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> setResultsStreet() async {
    setState(() {
      isLoading = true;
    });
    nearestCameras = await getCameras(_coordinates, currentUserToken);
    List IDs = getCamerasIDs(nearestCameras);
    snaps = await getStreetSnaps(IDs);
    data = await getFinalData(snaps, nearestCameras, _coordinates, currentUserToken);
    setState(() {
      isLoading = false;
    });
  }
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    currentLocation = Provider.of<Position>(context);
    provider = Provider.of<AppProvider>(context);
    Completer<GoogleMapController> _controller = Completer();


    return SafeArea(
      child: Scaffold(
          key: _scaffoldState,
        drawer: Appdrawer(context),
          body: Stack(
        children: [
          GoogleMap(
            //initialCameraPosition:(CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0)),
            initialCameraPosition: (currentLocation == null)
                ? (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0))
                : (CameraPosition(
                    target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 16.0)),
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
            },
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.menu_open),
                color: Colors.blueGrey,
                enableFeedback: true,
                padding: const EdgeInsets.all(0.0),
                iconSize: 30,
                onPressed: ()
                {
                  _scaffoldState.currentState.openDrawer();
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width* 1/8,
                ),

                Flexible(child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: GoogleSearch(context, _controller, currentLocation),
                ))
              ],
            ),
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
                  const Icon(Icons.album_outlined, color: Colors.black54),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                      heroTag: 'on-street',
                      onPressed: () async {
                        currentUserToken = provider.currentUser.token;
                        finalLocation();
                        if (_coordinates != null) {
                          await setResultsStreet();
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
                        "Find on-street",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton.extended(
                      heroTag: 'garages',
                      onPressed: () async {
                        currentUserToken = provider.currentUser.token;
                        finalLocation();

                        if (_coordinates != null) {
                            await setResultsGarage();
                            navigateTo(
                                context,
                                markedGarages(
                                  currentLocation: _coordinates,
                                  data: data,
                                ));
                        }
                      },
                      isExtended: true,
                      label: Text(
                        "Find garages",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      backgroundColor: Colors.blueGrey,
                    ),
                  ),
                ],
              )
            ),
          ),

          Center( child: isLoading == true ?
            loadingIndicator(context, "Processing Data... ", true)
                : Center(),
          )
        ],
      )),
    );
  }
}
