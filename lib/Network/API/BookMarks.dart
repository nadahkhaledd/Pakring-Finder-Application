import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Network/Dio_helper.dart';

import '../../Model/DBModels/Bookmark.dart';
import '../endpoints.dart';

Future<int> addBookmark(Bookmark bookmark, String token) async {
  Response response;
  await DioHelper.postData(url: AddBookMark, data: bookmark.toJson(), token: token)
      .then((value) {
        response=value;  })
      .catchError((onError) {response.statusCode;}
  );
  return response.statusCode;
}

Future<int> clearDriverBookmarks(String id, String token)
async {
  Dio dio = new Dio();
  String url = "http://164.92.174.146/";
  dio.options.headers = {"Authorization": 'Bearer $token'};
  Response response = await dio.delete(url+"clear_driver_bookmark?driverID=$id");
  return response.statusCode;
}
