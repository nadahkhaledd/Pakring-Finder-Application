import 'package:google_maps_flutter/google_maps_flutter.dart';
class Camera
{
  static const String COLLECTION_NAME  = 'Camera';
  String id;
  String address;
  LatLng location;

  String get getID => id;
  String get getAddress => address;
  LatLng get getLocation => location;


  Camera({ this.id,  this.address,  this.location});

}

