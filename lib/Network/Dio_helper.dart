import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  ///token to be changed to dynamic from current user
  static String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY1Njg4MjQ2MSwianRpIjoiYTdjMmI0YzctMGM1MS00ZTEyLThlMzktMjE0OWVmMjZhYTQ5IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6Im93bmVyIiwibmJmIjoxNjU2ODgyNDYxLCJleHAiOjE2NTc0ODcyNjF9.7tbY6oVgvuPkkTWFeIf-T_qZFYaN_BgTxTwpppxAC2s";
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
    dio.options.headers["Authorization"] = "Bearer " + token;
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    @required String url,
    @required Map<String,dynamic> data,
    //  Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token'
    };
    return await dio.post(url, data: data);
  }

}