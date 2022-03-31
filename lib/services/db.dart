import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Shared/calculations.dart';



class DB extends StatefulWidget
{
  var source;
  DB(this.source);
  @override
  State<DB> createState() => _DBState();
}

class _DBState extends State<DB> {
  final db = FirebaseDatabase.instance.reference();
  List nearest;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: db.child('Cameras').onValue,
        builder: (context, snapshot)
        {
          if(snapshot.hasData)
            {
              print('\n\nfirebaaaase\n\n');
              final all = Map<String, dynamic>.from(
                  (snapshot.data as Event).snapshot.value);
              all.forEach((key, value) {
                final nextLoc = Map<String, dynamic>.from(value);
                print('\n\nlatlat: ' + nextLoc['lat'].toString());
                if(isInRadius(widget.source, nextLoc['lat'], nextLoc['long']))
                  {
                    nearest.add({'lat': nextLoc['lat'], 'long': nextLoc['long']});
                  }
              });
            }
          printLocs(nearest);
          return Container();
        }
    );
  }
}


