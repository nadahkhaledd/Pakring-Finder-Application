import 'package:flutter/material.dart';
import 'package:park_locator/Network/API/UserAPi.dart';
import 'package:park_locator/screens/user/signup.dart';
import 'package:provider/provider.dart';

import '../../Model/UserData.dart';
import '../../Shared/Components.dart';
import '../../services/appprovider.dart';

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
                      //setState(() => controller.text = _fName);
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
                          //  String email="nada123@gmail.com";
                          //String pass= "nadahossam";
                          if (formKey.currentState.validate()) {

                          }
                          print(email);
                          userData  user =  await loginApi(
                              email: emailController.text,
                              password:passwordController.text);
                          provider.updateUser(user);

                          navigateTo(context,(){});

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