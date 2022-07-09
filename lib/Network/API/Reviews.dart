import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Model/UserData.dart';
import 'package:park_locator/Network/Dio_helper.dart';

import '../../Model/DBModels/Review.dart';
import '../endpoints.dart';
String url = "http://164.92.174.146/";
Future<int> addReview(
    {@required userData user,
    @required String cameraID,
    @required String content}) async {
  Response response;
  await DioHelper.postData(url:AddReview, token: user.token, data: {
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



 /* Response response = await dio.post(url + "Review/add", data: {
    'driverID': driverID,
    'cameraID': cameraID,
    'content': content,
    'garageID': ""
  });*/
  return response.statusCode;
}

// Future<List> getReviews({@required String cameraID}) async
// {
//   List<Review> review= [];
//   await DioHelper.getData(url: ShowStreetReview, query: {
//
//   })
//   Response response =await dio.get(url+"show_street_reviews?cameraID="+cameraID);
//   //print(response.data);
//   for(var element in response.data)
//   {
//     if(element !=null)
//     {
//       //print(review);
//       review.add(Review.fromJson(element));
//     }
//   }
//   return review;
// }