import 'package:cloud_firestore/cloud_firestore.dart';

// Future<List> getStreetSnaps (List nearestPlacesIDs)async
// {
//   List snaps =[];
//   await Future.forEach( nearestPlacesIDs,(element) async {
//     final snapshot = await FirebaseFirestore.instance.collection("Snaps").where("id", isEqualTo:element).orderBy("Date").get();
//     final allData = snapshot.docs.map((doc) => doc.data()).toList();
//     if (allData.length!=0)
//     {
//       snaps.add(allData.elementAt(0));
//     }
//   });
//   print("-------------------------------------------------------");
//   print(snaps);
//   return snaps;
// }
// Future<List> getSnapsgarage (List garageCameras)async
// {
//   List snaps =[];
//   await Future.forEach( garageCameras,(element) async {
//
//     final snapshot = await FirebaseFirestore.instance.collection("GarageSnaps").where("GarageCameraID", isEqualTo:element).orderBy("Date").get();
//     final allData = snapshot.docs.map((doc) => doc.data()).toList();
//
//     if (allData.length!=0)
//     {
//
//       snaps.add(allData.elementAt(0));
//     }
//   });
//   return snaps;
// }
