import 'package:dio/dio.dart';

import '../Dio_helper.dart';
import '../endpoints.dart';

Future<List> getStreetSnaps(List nearestPlacesIDs,String token)
async {
  List StreetSnaps= [];
  for(var id in nearestPlacesIDs)
  {
    if(id !=null)
    {
      Response response=await DioHelper.getData(url: getSnapsById+id, token: token);
      StreetSnaps.add(response);
    }
  }
  return StreetSnaps;
}

Future<List> getGarageSnaps(List GaragesCamerasIDs,String token)
async {
  List GarageSnaps= [];

  for(var id in GaragesCamerasIDs)
  {
    if(id !=null)
    {
      Response response=await DioHelper.getData(url: getGarageSnapsById+id, token: token);
      GarageSnaps.add(response);
    }
  }
  return GarageSnaps;
}