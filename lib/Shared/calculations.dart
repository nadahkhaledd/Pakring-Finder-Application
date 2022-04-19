import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Constants.dart';
import '../services/DistanceMatrix.dart';

Future<bool> isInRadius(LatLng current, LatLng loc)  async {

  String distance = await getDistance(loc,current);
  String d2=distance.substring(0,distance.length-3);
  if( double.parse(d2) <= 3.5)
    {
      return true;
    }
  else
    return false;
}
