import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';


class GoogleSearch extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchLocation(
        apiKey: 'YOUR_API_KEY',
        // The language of the autocompletion
        language: 'en',
        placeholder: 'Search location',
        iconColor: Colors.red,
        darkMode: true,
        //Search only work for this specific country
        country: 'EG',
        onSelected: (Place place) async {
          final geolocation = await place.geolocation;
          // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
          GoogleMapController mapController;
          mapController.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
          //controller.animateCamera(CameraUpdate.newLatLngBounds(, 0));
        },
      ),
    );
  }

}