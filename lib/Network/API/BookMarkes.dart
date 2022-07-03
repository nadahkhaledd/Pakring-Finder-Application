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
