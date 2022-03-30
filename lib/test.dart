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


class test extends StatelessWidget {
  @required Position current;
  @override
  void initState() {
    // TODO: implement initState

  }
  @override

  Widget build(BuildContext context) {

          return BlocProvider(
              create: (BuildContext context) => parkingLocatorCubit(),
              child: BlocConsumer<parkingLocatorCubit, parkingLocatorSates>(
              listener: (context, state) {
                parkingLocatorCubit.get(context). getDistanceAndTime(locs);

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
                ),Text(  locs[0].distance),
              ],
            ),
          );
       }
          ));


    }}

