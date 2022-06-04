import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/DBModels/Camera.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import 'package:park_locator/Model/DBModels/Owner.dart';

import '../../Shared/calculations.dart';

String url = "http://164.92.174.146/";
Dio dio = new Dio();

Future<List> getCameras(LatLng current)
async {
  List<Camera> nearestOnstreet= [];
  Response response=await dio.get(url+"Camera/get");

  for(var element in response.data)
  {
    if(element !=null)
      {
        LatLng location = LatLng(double.parse(element['location']['lat']), double.parse(element['location']['long']));
        bool condition = await isInRadius(current, location);
        if(condition)
        {
          nearestOnstreet.add(new Camera(id: element['id'], address: element['address'], location: location));
        }
      }
  }
  return nearestOnstreet;
}

 Future<List> getGarages(LatLng current)
async {
  List nearestGarages= [];
  Response response=await dio.get(url+"Garage/get");

  for(var element in response.data)
  {
    if(element !=null)
    {
      //LatLng location = LatLng(double.parse(element['location']['lat']), double.parse(element['location']['long']));
      LatLng location = LatLng(element['location']['lat'], element['location']['long']);
      bool condition = await isInRadius(current, location);
      if(condition)
      {
        nearestGarages.add({'id': element['id'], 'location': location, 'address': element['address'], 'cameraIDs': element['cameraIDs']});
      }
    }
  }
  return nearestGarages;
}

Future<List> getGarageCameras(LatLng current)
async {

  List garages = await getGarages(current);
  List garageCameras= [];
  Response response;

  for(var garage in garages)
    {
      List cameras = [];
      for(String id in garage['cameraIDs'])
        {
          response=await dio.get(url+"GarageCamera/get?id=$id");
          if(response.data != null)
            cameras.add({'cameraID': id, 'cameraAddress': response.data['address']});
        }
      garageCameras.add({'garageID': garage['id'], 'garageAddress': garage['address'],
        'location': garage['location'], 'cameras': cameras});
    }
  garageCameras.forEach((element) {print(element);});
  return garageCameras;
}
Future<LatLng> getGarageCamerasLocation(String GarageCameraID)
async {
  LatLng location;
  Response response=await dio.get(url+"GarageCamera/get?id="+GarageCameraID);
  if(response.data !=null)
  {
    String GarageID = response.data["garage_id"];
    Response response2=await dio.get(url+"Garage/get?id="+GarageID);
    if (response2.data != null)
    {
      location = LatLng(response2.data['location']['lat'], response2.data['location']['long']);
    }
  }
  return location;
}
Future<String> getGarageCamerasName(String GarageCameraID)
async {
  String name;
  Response response=await dio.get(url+"GarageCamera/get?id="+GarageCameraID);

  if(response.data !=null)
  {
    String GarageID = response.data["garage_id"];
    Response response2=await dio.get(url+"Garage/get?id="+GarageID);
      if (response2.data != null)
      {
         name = response2.data['address'];

      }



  }

  return name;
}


Future<List> getBookmarks({@required String driverID}) async
{
  List<Bookmark> bookmarks= [];
  Response response =await dio.get(url+"get_user_bookmark?driverID=$driverID");
  for(var element in response.data)
  {
    if(element !=null)
    {
      bookmarks.add(Bookmark.fromJson(element));
    }
  }
  return bookmarks;
}

Future<int> deleteBookmark(String id)
async {
  Response response = await dio.delete(url+"Bookmark/delete", data: {'id': id});
  return response.statusCode;
}


Future<List> getReviews(String cameraID) async
{
  List<Review> review= [];
  Response response =await dio.get(url+"show_street_reviews?cameraID="+cameraID);
  //print(response.data);
  for(var element in response.data)
  {
    if(element !=null)
    {
      //print(review);
      review.add(Review.fromJson(element));
    }
  }
  return review;
}



