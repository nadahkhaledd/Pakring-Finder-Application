import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/DBModels/Camera.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import 'package:park_locator/Model/DBModels/Owner.dart';
import 'package:park_locator/Network/API/requestSnaps.dart';
import 'package:park_locator/Network/Dio_helper.dart';

import '../../Network/endpoints.dart';
import '../../Shared/calculations.dart';

String url = "http://164.92.174.146/";
Dio dio = new Dio();

Future<List> getCameras(LatLng current, String token)
async {
  List<Camera> nearestOnstreet= [];
  Response response=await DioHelper.getData(url: url+"Camera/get", token: token);

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
 Future<List> getGarages(LatLng current, String token)
async {
  List nearestGarages= [];
  Response response=await DioHelper.getData(url: url+"Garage/get", token: token);

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
          response=await DioHelper.getData(url: url+"GarageCamera/get?id=$id", token: token);
          if(response.data != null)
            cameras.add({'cameraID': id, 'cameraAddress': response.data['address']});
        }
      garageCameras.add({'garageID': garage['id'], 'garageAddress': garage['address'],
        'location': garage['location'], 'cameras': cameras});
    }
  return garageCameras;
}
Future<LatLng> getGarageCamerasLocation(String GarageCameraID, String token)
async {
  LatLng location;
  Response response=await DioHelper.getData(url: url+"GarageCamera/get?id="+GarageCameraID, token: token);
  if(response.data !=null)
  {
    String GarageID = response.data["garageID"];
    Response response2=await DioHelper.getData(url: url+"Garage/get?id="+GarageID, token: token);
    if (response2.data != null)
    {
      location = LatLng(response2.data['location']['lat'], response2.data['location']['long']);
    }
  }
  return location;
}
Future<String> getGarageCamerasName(String GarageCameraID, String token)
async {
  String name;
  Response response=await DioHelper.getData(url: url+"GarageCamera/get?id="+GarageCameraID, token: token);

  if(response.data != null)
  {
    String GarageID = response.data["garageID"];
    Response response2=await DioHelper.getData(url: url+"Garage/get?id="+GarageID, token: token);
      if (response2.data != null)
      {
         name = response2.data['address'];

      }
  }
  return name;
}


Future<List> getBookmarks( String driverID, String token) async
{
  List<Bookmark> bookmarks= [];
  Response response =await DioHelper.getData(url: url+"get_user_bookmark?driverID=$driverID", token: token);
  for(var element in response.data)
  {
    if(element !=null)
    {
      bookmarks.add(Bookmark.fromJson(element));
    }
  }
  return bookmarks;
}

Future<int> deleteBookmark(String id, String token)
async {
  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"Bookmark/delete?id=$id");
  return response.statusCode;
}

Future<List> getReviews(String cameraID, String token) async
{
  List<Review> review= [];
  Response response =await DioHelper.getData(url: url+"show_street_reviews?cameraID="+cameraID, token: token);
  for(var element in response.data)
  {
    if(element !=null)
    {
      review.add(Review.fromJson(element));
    }
  }
  return review;
}



