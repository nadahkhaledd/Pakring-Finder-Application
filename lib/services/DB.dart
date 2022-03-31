import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/calculations.dart';

List getData(LatLng coords)
{
  List nearestPlaces = [];
  final db = FirebaseDatabase.instance.reference();
  db.child('Cameras').once().then((DataSnapshot snapshot) {
    List values = snapshot.value;
    values.forEach((element) {
      if(element != null)
        if(isInRadius(coords.latitude, coords.longitude, double.parse(element['lat']), double.parse(element['long'])))
          {
            LatLng location = LatLng(double.parse(element['lat']), double.parse(element['long']));
            nearestPlaces.add(location);
          }
    });
  });

  return nearestPlaces;
}


