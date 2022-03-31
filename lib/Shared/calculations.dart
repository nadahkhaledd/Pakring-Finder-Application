import 'dart:convert';
import 'dart:html';
import 'dart:math';

bool isInRadius(var source, var destinationLat, var destinationLong)
{
  var lat1 = pi * source.latitude / 180;
  var lat2 = pi * destinationLat / 180;
  var theta = source.longitude - destinationLong;
  var radTheta = pi * theta / 180;
  var distance = sin(lat1) * sin(lat2) + cos(lat1) * cos(lat2) * cos(radTheta);

  if(distance > 1) distance = 1;
  distance = acos(distance);
  distance = distance * 180 / pi;
  distance = distance * 60 * 1.1515 * 1.609344;

  if( distance <= 0.95)
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