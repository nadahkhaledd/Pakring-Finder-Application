import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:park_locator/Network/Dio_helper.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/screens/splash.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:splashscreen/splashscreen.dart';
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

    return ChangeNotifierProvider(
      create: (context)=> AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'parking locator',
        home: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapshot)
            {
              return splash();
            }
        ),
      ),
    );
  }
}


