// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:park_locator/Shared/Components.dart';
// import 'package:park_locator/screens/Home.dart';
//
// class splash extends StatefulWidget
// {
//   @override
//   State<splash> createState() => _splashState();
// }
//
// class _splashState extends State<splash> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     loadData();
//   }
//
//   Future<Timer> loadData() async {
//     return new Timer(Duration(seconds: 5), onDoneLoading);
//   }
//
//   onDoneLoading() async {
//     navigateTo(context, Home());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: new BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 100.0),
//               child: new Image.asset('assets/images/logo.jpg'),
//             )
//           ),
//
//           Container(
//             width: MediaQuery.of(context).size.width * 2/3,
//             alignment: Alignment.bottomCenter,
//             child: Center(
//               child: LinearProgressIndicator(
//                 color: Colors.blueGrey,
//                 backgroundColor: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/screens/user/signup.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Home.dart';

class splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new Home(),
      image: new Image.asset('assets/images/logo.jpg'),
      photoSize: 100.0,
      loaderColor: Colors.blueGrey,
      backgroundColor: Colors.white,
    );
  }
}