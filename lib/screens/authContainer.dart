import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/screens/user/login.dart';
import 'package:park_locator/sharedPrefreance/chached.dart';

import 'Home.dart';

class AuthContainer extends StatefulWidget {
  @override
  State<AuthContainer> createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  String token;

bool initial=true;

  @override
  Widget build(BuildContext context) {

    if(initial)
    {
      setState(() {
        token= userPrefrance.getToken();
        initial=false;
        print("TTTTTTTTt"+token);
      });

      return CircularProgressIndicator();
    }
    else
    {
      if(token==null)
        return login();
      else
        return Home();
    }
  }
}
