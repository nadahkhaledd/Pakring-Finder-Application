import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Shared/calculations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List ids=[];

Future<List> getData (LatLng coords)async
{
  List nearestPlaces = [];

  int id=-1;
  final db = await FirebaseDatabase.instance.reference();
  await db.child('Cameras').once().then((DataSnapshot snapshot) {
    List values = snapshot.value;
    values.forEach((element) {
      id++;
      if(element != null)
        if(isInRadius(coords.latitude, coords.longitude, double.parse(element['lat']), double.parse(element['long'])))
          {
            ids.add(id);
            LatLng location =  LatLng(double.parse(element['lat']), double.parse(element['long']));
            nearestPlaces.add(location);
          }
    });
  });
  return nearestPlaces;
}
void setIds()
{
  ids=[];
}
List getIds()
{
  return ids;
}

Future<List> getSnaps (List nearestPlaces)async
{
  List snaps =[];
  await Future.forEach( nearestPlaces,(element) async {
    final snapshot = await FirebaseFirestore.instance.collection("Snaps").where("Camera_ID", isEqualTo:element).orderBy("Date").get();
    final allData = snapshot.docs.map((doc) => doc.data()).toList();
     if (allData.length!=0)
      {
        snaps.add(allData.elementAt(0));
      }
  });

  return snaps;

  
}
