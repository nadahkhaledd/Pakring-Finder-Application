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
  Position _coordinates;
  Completer<GoogleMapController> _controller ;
  GoogleSearch(context, this._controller, this._coordinates);

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
        final GoogleMapController controller = await widget._controller.future;
        var location = LatLng(geolocation?.coordinates?.latitude,geolocation?.coordinates?.longitude);
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 18.0)));
        setState(() {
          widget._coordinates = Position(latitude: location.latitude, longitude: location.longitude);
          setSearchLocation(location);
        });

      },
    );
  }
}