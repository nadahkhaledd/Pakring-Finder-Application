import 'package:google_maps_flutter/google_maps_flutter.dart';
class Review
{
  static const String COLLECTION_NAME  = 'Review';
  String cameraID;
  String content;
  String date;
  String driverID;
  String garageID;
  String id;



  Review.fromJson(Map<String, dynamic> json) {
    driverID = json['driverID'];
    id = json['id'];
    garageID = json['garageID'];
    date = json['date'];
    content = json['content'];
    cameraID = json['cameraID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverID'] = this.driverID;
    data['garageID'] = this.garageID;
    data['date'] = this.date;
    data['id'] = this.id;
    data['content']=this.content;
    data['cameraID']=this.cameraID;
    return data;
  }

  Review({ this.id,  this.cameraID, this.content, this.date, this.driverID, this.garageID});

}

