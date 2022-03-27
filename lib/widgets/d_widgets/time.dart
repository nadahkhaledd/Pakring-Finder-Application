import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
class time extends StatelessWidget
{
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
                    Text("1 min ",
                      style:TextStyle(
                          color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    Text("(220 m)",
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