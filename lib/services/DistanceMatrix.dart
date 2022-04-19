import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


getDistanceMatrix(LatLng source, LatLng destination) async {
  String GoogleAPIKey = 'AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w';

   Dio dio = new Dio();
   Response response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&"
       "origins=${source.latitude},${source.longitude}&destinations=${destination.latitude},${destination.longitude}&"
       "key=$GoogleAPIKey");

   String distanceList = response.data['rows'][0]['elements'][0]['distance']['text'];
   String distance = distanceList.split(' ')[0];
   var result = {'address': response.data['destination_addresses'], 'distance': double.parse(distance)};

   return result;
}