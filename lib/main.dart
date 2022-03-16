import 'package:flutter/material.dart';
import 'package:park_locator/screens/search.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';

import 'marked/MarkedPlaces.dart';

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
        home: MarkedPlaces(),
      ),
    );
  }
}


