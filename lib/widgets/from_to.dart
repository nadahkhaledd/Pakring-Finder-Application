import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
class from_to extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(top:45.0,right: 0.0),
            width: 80,
            child: Column(
              children: [
                Container(

                  child:Icon(Icons.ac_unit),
                ),
                 Container(
                    padding: const EdgeInsets.only(top:20.0,right: 0.0),
                    child:Icon(Icons.icecream_outlined),
                  ),

              ],

            ),
          ),
    Padding(
          padding: const EdgeInsets.only(top:35.0,right: 0.0),
          child:Column(
            children: [
                Container(
                  height: MediaQuery.of(context).size.height*(0.2)*0.3,
                  width:MediaQuery.of(context).size.width*0.7,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name Here',
                      hintText: 'Enter Name Here',
                    ),
                    autofocus: false,
                  ),
                )
              ,
              Padding(
                padding: const EdgeInsets.only(left: 0,top:5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*(0.2)*0.3,
                  width:MediaQuery.of(context).size.width*0.7,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name Here',
                      hintText: 'Enter Name Here',
                    ),
                    autofocus: false,
                  ),
                ),
              )
            ],
      ))])
    );
  }

}