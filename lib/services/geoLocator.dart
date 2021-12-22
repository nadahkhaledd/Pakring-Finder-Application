import 'package:geolocator/geolocator.dart';

class geoLocator {

  Future<Position> getCurrentLocation() async {
    var locator = Geolocator();
    return await locator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);

  }
}