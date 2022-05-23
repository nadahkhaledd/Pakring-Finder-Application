import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/DBModels/Camera.dart';

import '../../Shared/calculations.dart';

String url = "http://164.92.174.146/";
Future<List> getCameras(LatLng current)
async {
  List<Camera> nearest= [];
  Dio dio = new Dio();
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
  Dio dio = new Dio();
  Response response =await dio.get(url+"get_user_bookmark?driverID=FQMeDG5YNwsyUXbDX4Ww");
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
  Dio dio = new Dio();
  Response response = await dio.delete(url+"Bookmark/delete", data: {'id': id});
  return response.statusCode;
}