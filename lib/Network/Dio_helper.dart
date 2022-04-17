import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init()///Object from Dio
  {
    dio = Dio(BaseOptions(
      baseUrl:"http://164.92.174.146",
      receiveDataWhenStatusError: true,

    ));
  }

  static Future<Response> getData({
    @required String url,
    @required Map<String,dynamic> query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String,dynamic> data,
    //  Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
    };
    return await dio.post(url, data: data);
  }

}