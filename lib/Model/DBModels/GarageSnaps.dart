import 'package:google_maps_flutter/google_maps_flutter.dart';
class Snaps
{
  static const String COLLECTION_NAME  = 'Snaps';
  String id;
  String paths;
  String garageCameraId;
  String capacity;
  String date;

  String get getID => id;
  String get getPaths => paths;
  String get getCameraId => garageCameraId;
  String get getCapacity => capacity;
  String get getDate => date;


  Snaps({ this.id,  this.capacity, this.garageCameraId, this.date, this.paths});

}

