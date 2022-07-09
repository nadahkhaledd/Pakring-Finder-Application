import 'package:flutter/material.dart';
import 'package:park_locator/Network/API/UserAPi.dart';
import 'package:park_locator/Shared/Constants.dart';
import 'package:park_locator/screens/user/signup.dart';
import 'package:park_locator/sharedPrefreance/chached.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/UserData.dart';
import '../../Shared/Components.dart';
import '../../Shared/pair.dart';
import '../../services/appprovider.dart';
import '../Home.dart';

class login extends StatefulWidget {
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  String email;
  AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: heightResponsive(
                          context: context,
                          height: 7,
                        )),
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: heightResponsive(
                        context: context,
                        height: 15,
                      ),
                    ),
                    defaultTextFormField(
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: "Email",
                      messageValidate: "email can't be empty",

                    ),
                    SizedBox(
                      height: heightResponsive(
                        context: context,
                        height: 15,
                      ),
                    ),
                    defaultTextFormField(
                      isPassword: true,
                      context: context,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      label: "password",
                      messageValidate: "can't be less than 6 char",
                      prefixIcon: const Icon(
                        Icons.password,
                      ),
                    ),
                    SizedBox(
                      height: heightResponsive(
                        context: context,
                        height: 15,
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            Pair pair=  new Pair("none","none");
                          pair=  await loginApi(
                                email: emailController.text,
                                password:passwordController.text);

                            if(pair.token!='none')
                              {
                                userData user=await getUserById(userID: pair.id,token: pair.token);
                                provider.updateUser(user);
                                // userPrefrance.setToken(pair.token);
                                 SharedPreferences pref= await SharedPreferences.getInstance();
                                 pref.setString(Constants.ACCESS_TOKEN, pair.token);
                                 pref.setString(Constants.ACCESS_ID, pair.id);
                                navigateAndFinish(context, Home());

                              }
                            else
                              {
                                showDialog(context: context,
                                    builder: (BuildContext context) =>
                                AlertDialog(

                                  title:  Text("Failed to Log in", style: TextStyle(
                                      color: Colors.red
                                  ),),
                                  content:  Text("Wrong Email or Password", style: TextStyle(
                                      color: Colors.red
                                  ),),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context,'ok'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ));
                              }

                          }

                        },
                        child: Text("Login"),

                      ),
                    ),
                    SizedBox(
                      height: heightResponsive(
                        context: context,
                        height: 25,
                      ),
                    ),
                    Row(children: [
                      Text("Don't have an account ? "),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, signup());
                          },
                          child: Text('Sign-up'))
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}