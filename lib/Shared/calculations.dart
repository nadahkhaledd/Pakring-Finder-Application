import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/DistanceMatrix.dart';

Future<bool> isInRadius(LatLng current, LatLng destination)  async {

  Map result = await getDistanceMatrix(current, destination);
  double distance = result['distance'];

  if(distance <= 1.5)
      return true;

  else
    return false;
}
