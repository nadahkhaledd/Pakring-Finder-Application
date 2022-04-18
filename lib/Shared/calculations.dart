import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:park_locator/Shared/Constants.dart';
import '../services/DistanceMatrix.dart';

Future<bool> isInRadius(var sourceLat, var sourceLong, var destinationLat, var destinationLong)  async {
  var result = await getDistanceMatrix(sourceLat, sourceLong, destinationLat, destinationLong);
  var distance = result['distance'] * 1.60934;

  // final distance = SphericalUtil.computeDistanceBetween(
  //     LatLng(sourceLat, sourceLong), LatLng(destinationLat, destinationLong)) / 1000.0;

  if( distance <= 3.5)
    {
      print('distance:' +  distance.toString());
      return true;
    }
  else
    return false;
}
