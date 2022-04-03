import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_locator/Network/Remote/Dio_helper.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/services/DB.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:park_locator/screens/getLocation.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';


Future<void> main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoLocatorService = geoLocator();
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return FutureProvider(
      create: (context) async => await geoLocatorService.getCurrentLocation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'parking locator',
        home: FutureBuilder(
          future: _firebaseApp,
            builder: (context, snapshot)
            {
              return start();
            }

        ),
      ),
    );
  }
}


class start extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Home(),
      image: new Image.asset('assets/images/logo.PNG'),
      photoSize: 100.0,
      loaderColor: Colors.red,
      backgroundColor: Colors.white,
    );
  }
}




