import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Functions.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';


class GoogleSearch extends StatefulWidget
{
  LatLng _coordinates;
  //Completer<GoogleMapController> _controller ;
  GoogleMapController _mapController;
  GoogleSearch(context, this._mapController, this._coordinates);

  @override
  State<GoogleSearch> createState() => _GoogleSearchState();
}

class _GoogleSearchState extends State<GoogleSearch> {

  @override
  Widget build(BuildContext context) {
    return SearchLocation(
      apiKey: 'AIzaSyAs891Qkhr9DA8kkG0TORJjwWCSCRE3Ot8',
      language: 'en',
      placeholder: 'Search location',
      iconColor: Colors.blueGrey,
      darkMode: true,
      country: 'EG',
      onClearIconPress: (){
        widget._coordinates = widget._coordinates;
      },
      onSelected: (Place place )  async {
        final geolocation = await place.geolocation;
        //final GoogleMapController controller = await widget._controller.future;
        setState(() {
          var location = LatLng(geolocation?.coordinates?.latitude,geolocation?.coordinates?.longitude);
          widget._mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: location, zoom: 18.0)));
          widget._coordinates = location;
          setSearchLocation(widget._coordinates);
        });

      },
    );
  }
}