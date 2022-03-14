import 'package:flutter/material.dart';
import 'package:park_locator/screens/direction_screen.dart';
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
        title: 'parking locator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: direction_screen(),
      ),
    );
  }
}


