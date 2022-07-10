import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:park_locator/widgets/loadingIndicator.dart';
import 'package:provider/provider.dart';

import '../Model/LocationDetails.dart';
import '../Shared/Components.dart';
import '../Shared/Functions.dart';
import '../Shared/Constants.dart';
import '../services/appprovider.dart';
import '../widgets/GoogleSearch.dart';
import 'marked/MarkedGarages.dart';
import 'marked/MarkedPlaces.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController _mapController;
  //Position currentLocation;
  AppProvider provider;
  String currentUserToken;
  LatLng _coordinates = LatLng(30.0313, 31.2107);
  List snaps, nearestCameras, nearestGarages,GarageSnaps;
  List<LocationDetails> data = [];
  bool isLoading = false;
  bool isSearchUsed = false;
  String voiceQuery = '';

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
    GarageSnaps = await getGarageSnaps(GaragesCamerasIDs,currentUserToken);
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
    snaps = await getStreetSnaps(IDs,currentUserToken);
    data = await getFinalData(snaps, nearestCameras, _coordinates, currentUserToken);
    setState(() {
      isLoading = false;
    });
  }

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var currentLocation = Provider.of<Position>(context);
    provider = Provider.of<AppProvider>(context);
    //Completer<GoogleMapController> _controller = Completer();


    return SafeArea(
      child: Scaffold(
          key: _scaffoldState,
        drawer: Appdrawer(context),
          body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:(CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0)),
            // initialCameraPosition: (currentLocation == null)
            //     ? (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 10.0))
            //     : (CameraPosition(
            //         target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 16.0)),
            compassEnabled: true,
            mapToolbarEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            rotateGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) async {
              //_controller.complete(controller);
              _mapController = controller;
            },
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
                //final GoogleMapController controller = await _controller.future;
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


          Align(
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
                      //child: const Icon(Icons.garage, color: Colors.white),
                      onPressed: () async {
                        currentUserToken = provider.currentUser.token;
                        setState(() {
                          finalLocation();
                        });
                        if (_coordinates != null) {
                          print(_coordinates.latitude);
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
                      //child: const Icon(Icons.garage, color: Colors.white),
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

          isSearchUsed?Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 40, right: 8, bottom: 8),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30),
                child: Slidable(
                  key: Key('google search'),
                  dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    onDismissed: (type)  {
                      setState(() {
                        isSearchUsed = false;
                      });
                    },),
                    actionPane: SlidableDrawerActionPane(),
                    actions: <Widget>[
                      IconSlideAction(
                        color: Colors.transparent,
                        icon: Icons.arrow_forward_ios,
                        foregroundColor: Colors.blueGrey,
                        onTap: ()
                        {
                          setState(() {
                            isSearchUsed = false;
                          });
                        },
                      )
                    ],
                    child: GoogleSearch(context, _mapController, _coordinates)),
              ),
            ),
          ): Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 19, left: 25, right: 25, bottom: 25),
              child: FloatingActionButton(
                heroTag: 'search',
                backgroundColor: Colors.blueGrey,
                mini: true,
                //shape: BeveledRectangleBorder(),
                child:
                const Icon(Icons.search, color: Colors.white),
                onPressed: () async {
                  setState(() {
                    isSearchUsed = true;
                  });
                },
              ),
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
