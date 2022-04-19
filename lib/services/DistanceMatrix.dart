import 'package:dio/dio.dart';



  getDistanceMatrix(double sourceLat, double sourceLong, double destLat, double destLong)
 async {
   Dio dio = new Dio();
   Response response=await dio.get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$sourceLat,$sourceLong&destinations=$destLat,$destLong&key=AIzaSyANNie-WxuIW_ibDpFjNPO5fICFWFfEk3w");
   String distance = response.data['rows'][0]['elements'][0]['distance']['text'];
   List splitDistance = distance.split(' ');
   var result = {'address': response.data['destination_addresses'], 'distance': double.parse(splitDistance[0])};

   return result;
}