

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import '../Model/directionsDetails.dart';
import '../Shared/Components.dart';
import '../screens/direction_screen.dart';

class review extends StatelessWidget
{
  List data;
  review(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(

        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
        child: Container(

          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blueGrey,
                );
              },
              itemBuilder: (context, index) => ListTile(


                title: Column(
                  children: [
                    Text("shahy",style: TextStyle(fontSize: 20,),),
                    Text("hi this is good hi")


                  ],
                ),
                subtitle: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text("20/10/2000"),
                    ),

                  ],
                ),
              )),

        ),
      ),
    );
  }


}
