import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/screens/authContainer.dart';
import 'package:splashscreen/splashscreen.dart';


class splash extends StatefulWidget {

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds:AuthContainer(),
      image: new Image.asset('assets/images/newlogo.jpg'),
      photoSize: 70.0,
      backgroundColor: Colors.white,
      loaderColor: Colors.blueGrey,
    );
  }
}