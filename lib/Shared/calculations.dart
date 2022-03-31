import 'dart:convert';
import 'dart:math';

bool isInRadius(var source, var destinationLat, var destinationLong)
{
  double lat1 = source.latitude * pi/180;
  double lat2 = destinationLat * pi/180;
  double lon1 = source.longitude * pi/180;
  double lon2 = destinationLong * pi/180;

  double lats = lat2 - lat1;
  double longs = lon2 - lon1;

  double formula = pow(sin(lats/2), 2) + cos(lat1) * cos(lat2) * pow(sin(longs/2), 2);

  double c = 2 * asin(sqrt(formula));
  double distance = c * 6371.0;  //distance in Kilometers


  if( distance <= 3.0)
    return true;
  else
    return false;
}

// void printLocs(List locs)
// {
//   print('\n\nlength:' + locs.length.toString());
//   for(int i=0; i<locs.length; i++)
//     {
//       print('lat:' + locs[i]['lat'].toString());
//     }
// }