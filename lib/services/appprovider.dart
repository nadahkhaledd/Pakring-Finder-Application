import 'package:flutter/material.dart';

import 'package:park_locator/services/geoLocator.dart';

import '../Model/UserData.dart';


class AppProvider extends ChangeNotifier{
  userData currentUser;
  geoLocator geoLocatorService;
  updateUser(userData user){
    currentUser = user;
    notifyListeners();
  }

}