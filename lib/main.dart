import 'package:flutter/material.dart';
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
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: start(),
      ),
    );
  }
}

class start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new search(),
      image: new Image.asset('assets/images/car.png'),
      photoSize: 70.0,
      loaderColor: Colors.red,
      backgroundColor: Colors.white12,
    );
  }
}


