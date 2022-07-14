import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Shared/calculations.dart';
import '../Dio_helper.dart';
import '../endpoints.dart';

Future<List> getGarages(LatLng current, String token)
async {
  List nearestGarages= [];
  Response response=await DioHelper.getData(url: getGarage, token: token);

  for(var element in response.data)
  {
    print(element);
    if(element !=null)
    {
      LatLng location = LatLng(double.parse(element['location']['lat']), double.parse(element['location']['long']));
      print(location);
      bool condition = await isInRadius(current, location);
      if(condition)
      {
        int code = 200;
        /// mocking camera to take a snap
        //int code = await takeSnap({'mock_garage':true, 'id': element['id']}, token);
        if(code == 200)
        {
          nearestGarages.add({'id': element['id'], 'location': location, 'address': element['address'], 'cameraIDs': element['cameraIDs']});
        }
      }
    }
  }
  return nearestGarages;
}

Future<List> getGarageCameras(LatLng current, String token)
async {

  List garages = await getGarages(current, token);
  List garageCameras= [];
  Response response;
  for(var garage in garages)
  {
    List cameras = [];
    for(String id in garage['cameraIDs'])
    {
      response=await DioHelper.getData(url: getGarageCameraById+id, token: token);
      if(response.data != null)
        cameras.add({'cameraID': id, 'cameraAddress': response.data['address'],'spot':0});
    }
    garageCameras.add({'garageID': garage['id'], 'garageAddress': garage['address'],
      'location': garage['location'], 'cameras': cameras});
  }
  return garageCameras;
}
Future<LatLng> getGarageCamerasLocation(String GarageCameraID, String token)
async {
  LatLng location;
  Response response=await DioHelper.getData(url: getGarageCameraById+GarageCameraID, token: token);
  if(response.data !=null)
  {
    String GarageID = response.data["garageID"];
    Response response2=await DioHelper.getData(url: getGarageById+GarageID, token: token);
    if (response2.data != null)
    {
      location = LatLng(double.parse(response2.data['location']['lat']),double.parse(response2.data['location']['long']));
    }
  }
  return location;
}
Future<String> getGarageCamerasName(String GarageCameraID, String token)
async {
  String name;
  Response response=await DioHelper.getData(url: getGarageCameraById+GarageCameraID, token: token);

  if(response.data != null)
  {
    String GarageID = response.data["garageID"];
    Response response2=await DioHelper.getData(url: getGarageById+GarageID, token: token);
    if (response2.data != null)
    {
      name = response2.data['address'];

    }
  }
  return name;
}
Future<String> getGarageCamerasAddress(String GarageCameraID, String token)
async {
  String address;
  Response response=await DioHelper.getData(url: getGarageCameraById+GarageCameraID, token: token);

  if(response.data != null)
  {
    address=response.data["address"];
  }
  return address;
}
Future<String> getGarageID(String GarageCameraID, String token)
async {
  String garageID;
  Response response=await DioHelper.getData(url: getGarageCameraById+GarageCameraID, token: token);

  if(response.data != null)
  {
    garageID = response.data["garageID"];
  }
  return garageID;
}


