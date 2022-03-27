import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;
  static init()///Object from Dio
  {
    dio = Dio(BaseOptions(
      baseUrl: '164.92.174.146:80/find',
      receiveDataWhenStatusError: true,
      headers: {}
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
    Map<String,dynamic> query,
    @required Map<String,dynamic> data,
})async{
    return await dio.post(url,data: data,queryParameters: query);
  }
}
