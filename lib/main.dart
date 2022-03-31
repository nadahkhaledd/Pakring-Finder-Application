import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_locator/services/db.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:park_locator/screens/getLocation.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';


Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoLocatorService = geoLocator();

  @override
  Widget build(BuildContext context) {
    //final s = getCameras();

    return FutureProvider(
      create: (context) => geoLocatorService.getCurrentLocation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'parking locator',
        home: start(),
      ),
    );
  }
}


class start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new getLocation(currentLocation),
      image: new Image.asset('assets/images/logo.PNG'),
      photoSize: 100.0,
      loaderColor: Colors.red,
      backgroundColor: Colors.white,
    );
  }
}




