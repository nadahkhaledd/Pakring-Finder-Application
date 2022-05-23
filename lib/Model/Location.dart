class Location{
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  Map<String, Object> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}



class Geometry {
  final Location location;

  Geometry({this.location});
}