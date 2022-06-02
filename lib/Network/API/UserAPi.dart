import 'package:flutter/material.dart';

import '../../Model/UserData.dart';
import '../Dio_helper.dart';
import '../endpoints.dart';

Future<String> getUserNameByID({ @required String userID}) async
{
  String userName;
  await DioHelper.getData(url: GetById, query: {
    'id':userID
  }).then((value) {

    userName=value.data['name'].toString();

  }).catchError((error){
    print(error);
  });

return userName;
}


Future <userData>loginApi({
  @required String email,
  @required String password,
}) async {
  userData user;
  await DioHelper.getData(url: LOGIN, query: {
    'email':email,
    'password':password
  }

  ).then((value) {
    print(value.toString());
    print("TRUEEEEEEEEEEEEEEE");
    user = new userData(
      value.data['name'].toString(),
      value.data['email'].toString(),
      value.data['number'].toString(),
      value.data['id'].toString(),
    );

  }).catchError((error){
    print(error);
  });
  return user;
}

Future <userData> signupApi({
  @required String email,
  @required String password,
  @required String name,
  @required String number,
}) async {
  userData user;

  await DioHelper.postData(url: SIGNUP, data: {
    "email":email,
    "password":password,
    "name":name,
    "number":number,
    "is_owner":"False",
  }
  ).then((value) {
    print("EEEEEEEEEEEEEee");
    user = new userData(
      value.data['name'].toString(),
      value.data['email'].toString(),
      value.data['number'].toString(),
      value.data['id'].toString(),
    );
  }).catchError((error){
    print(error);
  });
  return user;
}

