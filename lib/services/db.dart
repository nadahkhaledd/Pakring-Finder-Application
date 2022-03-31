import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final db = FirebaseDatabase.instance.reference();
final Cameras = db.child('Cameras');
final snaps = db.child('Snaps');

FutureBuilder<DataSnapshot> getCameras()
{
  List cameras;
  print('\n\nfunction\n');
  return FutureBuilder(
    future: Cameras.once(),
    builder: (context, AsyncSnapshot<DataSnapshot> snapshot)
    {
      if(snapshot.hasData)
        {
          Map<dynamic, dynamic> values = snapshot.data.value;
          values.forEach((key, value) {
            cameras.add(values);
          });
        }
      print('Cameras\n\n');
      for (int i=0; i<cameras.length; i++)
        {
          print(cameras[i]);
        }
      return Container();
    },
  );
}

