import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'directionsModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  Dio dio = new Dio();


//  Dio dio = new Dio();
 // Response response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=29.976253314162836,31.01812820881605&destinations=29.96452052837998, 31.102888360619545&key=AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w");
 // print(response.data["destination_addresses"][0]);

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': "AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w",
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return null;
  }
}