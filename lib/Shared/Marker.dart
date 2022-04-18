import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/directionsDetails.dart';

import '../Model/LocationDetails.dart';

Set<Marker> addMarkers(List<LocationDetails> loc) {
  final Set<Marker> markers = new Set();
  for (int i = 0; i < loc.length; i++) {
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(loc[i].name),
      position: LatLng(loc[i].location.latitude, loc[i].location.longitude),
      icon: BitmapDescriptor.defaultMarker,
    ));
  }
  return markers;
}
Set<Marker> addMarkers2(LatLng loc,LatLng loc2) {
  final Set<Marker> markers = new Set();

    markers.add(Marker(
      //add first marker
      markerId: MarkerId(loc.latitude.toString()+loc.longitude.toString()),
      position: LatLng(loc.latitude, loc.longitude),
      icon: BitmapDescriptor.defaultMarker,
    ));
  markers.add(Marker(
    //add first marker
    markerId: MarkerId(loc2.latitude.toString()+loc2.longitude.toString()),
    position: LatLng(loc2.latitude, loc2.longitude),
    icon: BitmapDescriptor.defaultMarker,
  ));

  return markers;
}