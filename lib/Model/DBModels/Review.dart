import 'package:google_maps_flutter/google_maps_flutter.dart';
class Review
{
  static const String COLLECTION_NAME  = 'Review';
  String cameraID;
  String content;
  String date;
  String driverName;
  String garageID;
  String id;



  Review.fromJson(Map<String, dynamic> json) {
    driverName = json['driverID']['name'];
    id = json['id'];
    garageID = json['garageID'];
    date = json['date'];
    content = json['content'];
    cameraID = json['cameraID'];
  }



  Review({ this.id,  this.cameraID, this.content, this.date, this.driverName, this.garageID});

}

