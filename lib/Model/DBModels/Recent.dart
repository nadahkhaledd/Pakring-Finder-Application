import 'package:flutter/material.dart';
import 'package:park_locator/Model/Location.dart';

class Recent {
  String driverID;
  List<recent> history = [];


  Recent({this.driverID, this.history});

  Recent.fromJson(Map<String, dynamic> json) {
    driverID = json['driverID'];
    if (json['history'] != null && json['history'].length>0) {
      for (var r in json['history']) {
        if(r != null)
          history.add(new recent.fromJson(r['recent']));
      }
    }
  }
}


class recent {
  String address;
  String locationURL;
  Location location;

  recent({@required this.address, @required this.location, @required this.locationURL});

  recent.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    locationURL = json['locationURL'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['address'] = this.address;
    data['locationURL'] = this.locationURL;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    return data;
  }
}
