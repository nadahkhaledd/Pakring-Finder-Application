class Bookmark {
  String driverID;
  String id;
  Location location;
  String name;

  Bookmark({this.driverID, this.id, this.location, this.name});

  Bookmark.fromJson(Map<String, dynamic> json) {
    driverID = json['driverID'];
    id = json['id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverID'] = this.driverID;
    data['id'] = this.id;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['name'] = this.name;
    return data;
  }
}

class Location {
  double lat;
  double long;

  Location({this.lat, this.long});

  Location.fromJson(Map<String, dynamic> json) {
    lat = double.parse(json['lat']);
    long = double.parse(json['long']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat.toString();
    data['long'] = this.long.toString();
    return data;
  }
}
