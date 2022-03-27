import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Model/LocationDetails.dart';

Set<Marker> addMarkers( List<LocationDetails> loc )
{
  final Set<Marker> markers = new Set();
  for(int i=0;i<loc.length;i++)
  {
    markers.add(Marker( //add first marker
      markerId: MarkerId(loc[i].name),
      position: LatLng(loc[i].location.lat, loc[i].location.lng),
      icon: BitmapDescriptor.defaultMarker,
//Icon for Marker
    ));
  }
  return markers;
}