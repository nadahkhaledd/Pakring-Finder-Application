import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  List<Camera> nearest= [];
  Response response=await dio.get(url+"Camera/get");

  for(var element in response.data)
  {
    if(element !=null)
      {
        LatLng location = LatLng(double.parse(element['location']['lat']), double.parse(element['location']['long']));
        bool condition = await isInRadius(current, location);
        if(condition)
        {
          nearest.add(new Camera(id: element['id'], address: element['address'], location: location));
        }
      }
  }
  return nearest;
}


Future<List> getBookmarks(String driverID) async
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

Future<int> addBookmark(Bookmark bookmark)
async {
  Response response = await dio.post(url+"Bookmark/add", data:
  {'driverID': bookmark.driverID, 'name': bookmark.name,
  'location':{'lat': bookmark.location.lat.toString(), 'long': bookmark.location.long.toString()}});
  print(response.statusMessage);
  return response.statusCode;
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


Future<String> getUserNameByID(String userID) async
{
  String user;

  Response response =await dio.get(url+"get_by_id?id="+userID);
  user=response.data['name'];
  return user;
}



Future<int> addReview(String driverID,String cameraID,String content)
async {
  Response response = await dio.post(url+"Review/add", data: {'driverID': driverID,'cameraID':cameraID,'content':content,'garageID':""});
  return response.statusCode;
}