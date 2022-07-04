import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Network/Dio_helper.dart';
import 'package:park_locator/screens/Home.dart';
import 'package:park_locator/screens/splash.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';


Future<void> main()  async{
  DioHelper.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geoLocatorService = geoLocator();
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context)=> AppProvider() ),
        FutureProvider(create:(context) async => await geoLocatorService.getCurrentLocation(),
        lazy: false,
        )
      ],


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