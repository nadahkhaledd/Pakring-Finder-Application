
bool isInRadius(var source, var destinationLat, var destinationLong)
{
  return true;
}

void printLocs(List locs)
{
  print('\n\nlength:' + locs.length.toString());
  for(int i=0; i<locs.length; i++)
    {
      print('lat:' + locs[i]['lat'].toString());
    }
}