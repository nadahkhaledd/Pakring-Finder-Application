import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import 'package:park_locator/Shared/Components.dart';
import 'package:park_locator/screens/marked/MarkedPlaces.dart';

import 'Cubit/States.dart';
import 'Cubit/cubit.dart';

class test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => parkingLocatorCubit(),

      child: BlocConsumer<parkingLocatorCubit, parkingLocatorSates>(

      listener:(context,state){} ,
      builder: (context,state){
        return Center(
        child: ElevatedButton(child: Text("F"),onPressed: (){
          navigateTo(context, MarkedPlaces());
  },),
        );
  }
  ,
      ),
    );
  }
}
