import 'package:flutter/cupertino.dart';
import 'package:park_locator/Model/Location.dart';

class Bookmark {
  String driverID;
  String id;
  Location location;
  String name;
  String locationURL;

  Bookmark({@required this.driverID, this.id, @required this.location, @required this.name, @required this.locationURL});

  Bookmark.fromJson(Map<String, dynamic> json) {
    driverID = json['driverID'];
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
    locationURL = json['locationURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverID'] = this.driverID;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['name'] = this.name;
    data['locationURL'] = this.locationURL;
    return data;
  }
}

