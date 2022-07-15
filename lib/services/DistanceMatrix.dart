import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


getDistanceMatrix(LatLng source, LatLng destination) async {
  String googleAPIKey = 'AIzaSyAs891Qkhr9DA8kkG0TORJjwWCSCRE3Ot8';

   Dio dio = new Dio();
   Response response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&"
       "origins=${source.latitude},${source.longitude}&destinations=${destination.latitude},${destination.longitude}&"
       "key=$googleAPIKey");
   double distance = double.parse(response.data['rows'][0]['elements'][0]['distance']['text'].split(' ')[0]) * 1.609;
   String duration = response.data['rows'][0]['elements'][0]['duration']['text'];
   var result = {'address': response.data['destination_addresses'], 'distance': distance, 'duration':duration};

   return result;
}