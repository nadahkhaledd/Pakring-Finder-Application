import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Network/endpoints.dart';

import '../../Model/DBModels/Camera.dart';
import '../../Shared/calculations.dart';
import '../Dio_helper.dart';

Future<List> getCameras(LatLng current, String token)
async {
  List<Camera> nearestOnstreet= [];
  Response response=await DioHelper.getData(url: getCamera, token: token);

  for(var element in response.data)
  {
    if(element !=null)
    {
      LatLng location = LatLng(double.parse(element['location']['lat']), double.parse(element['location']['long']));
      bool condition = await isInRadius(current, location);
      if(condition)
      {
        int code = 200;
        /// mocking camera to take a snap
        //int code = await takeSnap({'mock_garage':false, 'id': element['id']}, token);
        if(code == 200)
        {
          nearestOnstreet.add(new Camera(id: element['id'], address: element['address'], location: location));
        }
      }
    }
  }
  return nearestOnstreet;
}

