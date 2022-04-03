import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/marked/MarkedPlaces.dart';
import 'package:search_map_location/utils/google_search/latlng.dart';

import 'Cubit/States.dart';
import 'Cubit/cubit.dart';
import 'Model/LocationDetails.dart';
import 'Network/Dio_helper.dart';
import 'Network/endpoints.dart';
import 'Shared/Constants.dart';


class test extends StatelessWidget {
  @required Position current;
  @override
  void initState() {
    // TODO: implement initState

  }
  @override

  Widget build(BuildContext context) {
    String getCapacity;
          return BlocProvider(
              create: (BuildContext context) => parkingLocatorCubit()..getData(url: "https://firebasestorage.googleapis.com/v0/b/parkingfinder-589b5.appspot.com/o/2ce42c9d1876a0c2dd0862a7bb8ef6db.jpg?alt=media&token=88278d5b-4bd2-4757-8ef8-797e094cbe71", capacity: "5"),

              child: BlocConsumer<parkingLocatorCubit, parkingLocatorStates>(
              listener: (context, state) {
    },
       builder: (context, state) {
       return   Scaffold(
            body: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: ElevatedButton(
                      child: Text('do'),
                        onPressed: (){
                     //     getData(url: "https://firebasestorage.googleapis.com/v0/b/parkingfinder-589b5.appspot.com/o/2ce42c9d1876a0c2dd0862a7bb8ef6db.jpg?alt=media&token=88278d5b-4bd2-4757-8ef8-797e094cbe71", capacity: "3");

                          //navigateTo(context, MarkedPlaces(null));
                        }),
                  ),
                ),
                parkingLocatorCubit.get(context).getCapacity==null?CircularProgressIndicator():
                Text(parkingLocatorCubit.get(context).getCapacity),
              ],
            ),
          );
       }
          ));


    }}

