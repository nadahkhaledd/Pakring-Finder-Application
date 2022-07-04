import 'package:flutter/material.dart';
import 'package:park_locator/Network/API/UserAPi.dart';
import 'package:park_locator/screens/user/signup.dart';
import 'package:provider/provider.dart';

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

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    //child: Image.asset('assets/images/logopng.png', height: 150,width: 150,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: defaultTextFormField(
                    prefixIcon: const Icon(
                      Icons.email,
                    ),
                    context: context,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: "Email",
                    messageValidate: "email can't be empty",

                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: defaultTextFormField(
                    isPassword: true,
                    context: context,
                    //setState(() => controller.text = _fName);
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    label: "password",
                    messageValidate: "can't be less than 6 char",
                    prefixIcon: const Icon(
                      Icons.password,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          Pair pair=  new Pair("none","none");
                        pair=  await loginApi(
                              email: emailController.text,
                              password:passwordController.text);

                          if(pair.token!="none")
                            {
                              userData user=await getUserById(userID: pair.id,token: pair.token);
                              provider.updateUser(user);
                              navigateTo(context, Home());

                            }
                          else
                            {
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
                              );
                            }

                        }

                      },
                      child: Text("Login"),

                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 26, bottom: 26),
                  child: Row(children: [
                    Text("Don't have an account ? "),
                    TextButton(
                        onPressed: () {
                          navigateTo(context, signup());
                        },
                        child: Text('Sign-up'))
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}