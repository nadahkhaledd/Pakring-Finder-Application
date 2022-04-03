import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/calculations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List ids=[];

Future<List> getNearestCameras(LatLng coordinates)async
{
  List nearestPlaces = [];

  final db = await FirebaseDatabase.instance.reference();
  await db.child('Cameras').once().then((DataSnapshot snapshot) {
    List values = snapshot.value;
    values.forEach((element) {
      if(element != null)
        if(isInRadius(coordinates.latitude, coordinates.longitude, double.parse(element['lat']), double.parse(element['long'])))
          {
            LatLng location =  LatLng(double.parse(element['lat']), double.parse(element['long']));
            nearestPlaces.add({'id':element['id'], 'location': location, 'address': element['address']});
          }
    });
  });
  return nearestPlaces;
}

Future<List> getSnaps (List nearestPlacesIDs)async
{
  print('in snaps');
  List snaps =[];
  await Future.forEach( nearestPlacesIDs,(element) async {
    final snapshot = await FirebaseFirestore.instance.collection("Snaps").where("Camera_ID", isEqualTo:element).orderBy("Date").get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
     if (allData.length!=0)
      {
        snaps.add(allData.elementAt(0));
      }
  });

  return snaps;
}
