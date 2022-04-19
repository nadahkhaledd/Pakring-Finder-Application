import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/Constants.dart';
import '../services/DistanceMatrix.dart';

Future<bool> isInRadius(LatLng current, LatLng destination)  async {

  var result = await getDistanceMatrix(current.latitude, current.longitude, destination.latitude, destination.longitude);
  var distance = result['distance'];
  if(distance <= 3.5)
    {
      return true;
    }
  else
    return false;
}
