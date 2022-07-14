

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import '../Model/directionsDetails.dart';
import '../Shared/Components.dart';
import '../screens/direction_screen.dart';

class review extends StatelessWidget
{
  List reviews;
  List users;
  review(this.reviews,this.users);
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
              itemCount: reviews.length,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blueGrey,
                );
              },
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 3),
                child: Container(
                  padding:EdgeInsets.all(15) ,
                  child: Column(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child:
                          Text(users[index],style: TextStyle(color: Colors.blueGrey,fontSize: 17,fontWeight: FontWeight.bold),)),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(reviews[index].content,style: TextStyle(fontSize: 15,), overflow: TextOverflow.fade),
                          )),

                      Align(
                          alignment: Alignment.bottomRight,
                          child: Text(reviews[index].date, style: TextStyle(color: Colors.grey, fontSize: 14))),
                    ],
                  ),
                ),
              ),),

        ),
      ),
    );
  }


}
