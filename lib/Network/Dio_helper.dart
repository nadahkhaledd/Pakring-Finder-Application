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
    String token,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (token != null) "Authorization": 'Bearer $token',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    @required String url,
    String token,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      if (token != null) "Authorization": 'Bearer $token',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


}