import 'package:dio/dio.dart';
import 'package:park_locator/Network/Dio_helper.dart';
import 'package:park_locator/Network/endpoints.dart';

Future<int> takeSnap(Map data, String token)
async {
  Response response;
  await DioHelper.postData(url: requestSnap, data: data, token: token)
      .then((value) {
    response=value;  })
      .catchError((onError) {response.statusCode;}
  );
  return response.statusCode;
}