import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:park_locator/services/directionsModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;

  DirectionsRepository({Dio dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '$origin',
        'destination': '$destination',
        'key': "AIzaSyCzbqSGIBhYBESRpmRClVzksek58sJjcjo",
      },
    );

    // Check if response is successful
    if (response.statusCode == 200) {
      print(response.data);
      return Directions.fromMap(response.data);
    }
    return null;
  }
}