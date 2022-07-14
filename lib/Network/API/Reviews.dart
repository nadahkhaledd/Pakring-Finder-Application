import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Model/UserData.dart';
import 'package:park_locator/Network/Dio_helper.dart';

import '../../Model/DBModels/Review.dart';
import '../endpoints.dart';

Future<int> addStreetReview(
    {@required userData user,
    @required String cameraID,
    @required String content}) async {
  Response response;
  await DioHelper.postData(url: AddReview, token: user.token, data: {
      'driverID': user.id,
      'cameraID': cameraID,
      'content': content,
      'garageID': ""
    }).then((value) {
     response=value;
  }).catchError((error){
      print(error);
      response=error;
    });

  return response.statusCode;
}
Future<int> addGarageReview(
    {@required userData user,
      @required String cameraID,
      @required String content,
      @required String garageID}) async {
  Response response;
  await DioHelper.postData(url: AddReview, token: user.token, data: {
    'driverID': user.id,
    'cameraID': cameraID,
    'content': content,
    'garageID': garageID
  }).then((value) {
    response=value;
  }).catchError((error){
    print(error);
    response=error;
  });

  return response.statusCode;
}

Future<List> getReviews(String cameraID, String token) async
{
  List<Review> review= [];
  Response response =await DioHelper.getData(url: getReview+"?cameraID="+cameraID, token: token);
  for(var element in response.data)
  {
    if(element !=null)
    {
      review.add(Review.fromJson(element));
    }
  }
  return review;
}



