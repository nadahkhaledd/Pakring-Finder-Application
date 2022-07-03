import 'package:flutter/material.dart';

import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';

import '../Model/UserData.dart';


class AppProvider with ChangeNotifier{
  userData currentUser;
  //geoLocator geoLocatorService;
  updateUser(userData user){
    currentUser = user;
    notifyListeners();
  }

}