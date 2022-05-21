import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Constants.dart';
import 'package:provider/provider.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';


class GoogleSearch extends StatefulWidget
{
  var _coordinates;
  GoogleMapController _mapController;
  GoogleSearch( this._mapController);
  @override
  State<GoogleSearch> createState() => _GoogleSearchState();
}

class _GoogleSearchState extends State<GoogleSearch> {

  @override
  Widget build(BuildContext context) {
    return SearchLocation(
      apiKey: 'AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w',
      language: 'en',
      placeholder: 'Search location',
      iconColor: Colors.blueGrey,
      darkMode: true,
      country: 'EG',
      onClearIconPress: (){
        widget._coordinates = widget._coordinates;
      },
      onSelected: (Place place ) async {
        final geolocation = await place.geolocation;
        var location = LatLng(geolocation?.coordinates?.latitude,geolocation?.coordinates?.longitude);
        widget._mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 18.0)));
        setState(() {
          widget._coordinates = location;
          setSearchLocation(widget._coordinates);
        });

      },
    );
  }
}