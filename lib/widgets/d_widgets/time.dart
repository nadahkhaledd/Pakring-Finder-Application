import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
class time extends StatelessWidget
{

  final String totalDistance;
  final String totalDuration;

  const time({

    @required this.totalDistance,
    @required this.totalDuration,
  });
  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top:20,left:20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
              children:
              [
                Row(
                  children: [
                    Text(totalDuration,
                      style:TextStyle(
                          color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    Text(" ("+totalDistance+")",
                      style:TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top:7.0),
                  child: Text("Fastest route due to traffic condition",
                    style:TextStyle(
                        fontSize: 17
                    ),),
                )
                ]),
        )
    );
  }

}