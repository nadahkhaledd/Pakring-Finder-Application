import 'package:flutter/material.dart';
import 'package:park_locator/sharedPrefreance/chached.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Model/UserData.dart';


class AppProvider extends ChangeNotifier{
  userData currentUser;
  updateUser(userData user){
    currentUser = user;
    notifyListeners();
  }


}