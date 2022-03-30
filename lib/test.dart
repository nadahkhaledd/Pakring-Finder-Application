import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/marked/MarkedPlaces.dart';
import 'package:search_map_location/utils/google_search/latlng.dart';

import 'Cubit/States.dart';
import 'Cubit/cubit.dart';
import 'Model/LocationDetails.dart';
import 'Shared/Constants.dart';


class test extends StatefulWidget {
  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @required Position current;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    parkingLocatorCubit.get(context). getDistanceAndTime(locs);
  }
  @override

  Widget build(BuildContext context) {

          return BlocProvider(
            create: (BuildContext context) => parkingLocatorCubit(),
              child: BlocConsumer<parkingLocatorCubit, parkingLocatorSates>(
              listener: (context, state) {
          },
       builder: (context, state) {

                return   Scaffold(
            body: Column(
              children: [

                Center(
                  child: ElevatedButton(
                    child: Text('do'),
                      onPressed: (){

                      navigateTo(context, MarkedPlaces(null));
                      }),
                ),Text(dt.length.toString()),
              ],
            ),
          );
       }
          ));


    }}

