import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';


class GoogleSearch extends StatefulWidget
{
  var coordinates;
  GoogleMapController _mapController;
  GoogleSearch(this._mapController);
  @override
  State<GoogleSearch> createState() => _GoogleSearchState();
}

class _GoogleSearchState extends State<GoogleSearch> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchLocation(
        apiKey: 'AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w',
        language: 'en',
        placeholder: 'Search location',
        iconColor: Colors.red,
        darkMode: true,
        country: 'EG',
        onSelected: (Place place ) async {
          final geolocation = await place.geolocation;
          var location = LatLng(geolocation?.coordinates?.latitude,geolocation?.coordinates?.longitude);
          widget._mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: location, zoom: 18.0, bearing: -5.0, tilt: 45.0)));
        },
      ),
    );
  }
}