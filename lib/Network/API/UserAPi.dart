import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../Model/UserData.dart';
import '../../Shared/pair.dart';
import '../Dio_helper.dart';
import '../endpoints.dart';

Future<String> getUserNameByID({ @required String userID, String token}) async
{
  String userName;
  await DioHelper.getData(url: GetById, token: token,query: {
    'id':userID
  }).then((value) {

    userName=value.data['name'].toString();

  }).catchError((error){
    print(error);
  });

return userName;
}


 editUserInfo(String token, @required String userID,@required String userName,@required String userEmail,@required String userNumber,@required String userOldPass,@required String userNewPass)async
{

  await DioHelper.putData(url: updateUser,token: token, data: {
    "id":userID,
    "name":userName,
    "email":userEmail,
    "number":userNumber,
    "old_password":userOldPass,
    "new_password":userNewPass,
  }).then((value) {
    print(value);
  }).catchError((error){
    print(error);
  });


}

Future<userData> getUserById({@required String userID,@required String token}) async
{
  userData user;
  await DioHelper.getData(url: GetById, query: {"id":userID},token: token)
      .then((value) {
    user = new userData(
      value.data['name'].toString(),
      value.data['email'].toString(),
      value.data['number'].toString(),
      value.data['id'].toString(),
      token,
    );
  }).catchError((error){
    print(error);
  });
  return user;
}

Future <Pair>loginApi({
  @required String email,
  @required String password,
}) async {
  userData user;

 Pair pair=new Pair('none','none');

  await DioHelper.getData(url: LOGIN, query: {
    'email':email,
    'password':password
  }
  ).then((value) {
    pair= Pair(value.data['id'].toString(), value.data['idToken'].toString());

  }).catchError((error){
    print(error);
    pair=new Pair('none','none');
  });
  return pair;
}

Future <String> signupApi({
  @required String email,
  @required String password,
  @required String name,
  @required String number,
}) async {
  String returnValue;

  await DioHelper.postData(url: SIGNUP, data: {
    "email":email,
    "password":password,
    "name":name,
    "number":number,
    "role": "driver"
  }
  ).then((value) {
    returnValue=value.data['value'].toString();

  }).catchError((error){
    print(error);
    returnValue="Wrong format of email or phone number";
  //  return returnValue;
  });
  return returnValue;
}

