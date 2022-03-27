import 'package:flutter/material.dart';
import 'package:park_locator/Network/Remote/Dio_helper.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:park_locator/screens/search.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final geoLocatorService = geoLocator();

  @override
  Widget build(BuildContext context) {

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
    return SplashScreen(
      seconds: 8,
      navigateAfterSeconds: new search(),
      image: new Image.asset('assets/images/logo.PNG'),
      photoSize: 100.0,
      loaderColor: Colors.red,
      backgroundColor: Colors.white,
    );
  }
}




