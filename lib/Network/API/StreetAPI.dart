import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Model/Location.dart';
import '../../Model/LocationDetails.dart';
import '../../Shared/Constants.dart';
import '../Dio_helper.dart';
import '../endpoints.dart';

Future<String> getStreetData(
    {@required String url, @required String capacity}) async {
  String getCapacity;
  await DioHelper.postData(url: FIND, data: {
    "url": url,
    "capacity": capacity,
  }).then((value) {
    getCapacity = value.data["spots"].toString();
  }).catchError((error) {
    print(error.toString());
  });
  return getCapacity;
}

