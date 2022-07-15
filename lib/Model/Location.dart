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