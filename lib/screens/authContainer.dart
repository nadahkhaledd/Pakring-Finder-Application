import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:park_locator/Model/UserData.dart';
import 'package:park_locator/Shared/Constants.dart';
import 'package:park_locator/screens/user/login.dart';
import 'package:park_locator/sharedPrefreance/chached.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Network/API/UserAPi.dart';
import '../services/appprovider.dart';
import '../widgets/loadingIndicator.dart';
import 'Home.dart';

class AuthContainer extends StatefulWidget {
  @override
  State<AuthContainer> createState() => _AuthContainerState();
}

class _AuthContainerState extends State<AuthContainer> {
  String token;
  String id;
bool initial=true;
  AppProvider provider;
  @override
  Widget build(BuildContext context)
  {

    provider = Provider.of<AppProvider>(context);
    userData user;

    if(initial)
     {
      SharedPreferences.getInstance().then((sharedPrefValue) {
        setState(()  {
          initial = false;
          token = sharedPrefValue.getString(Constants.ACCESS_TOKEN);
          id = sharedPrefValue.getString(Constants.ACCESS_ID);
        });
      });

      return CircularProgressIndicator();
    }
    else
    {
      if(token==null)
        return login();
      else

        {
          return FutureBuilder<userData>(
              future:  getUserById(userID: id,token: token),
              builder: (context, AsyncSnapshot<userData> snapshot) {
                if (snapshot.hasData) {
                  provider.updateUser(snapshot.requireData);
                  return Home();

                } else {
                  return Scaffold(
                    body:Center(child: loadingIndicator(context,"Loading",true)),
                  );

                }
              }

          );

        }

    }
  }
}
