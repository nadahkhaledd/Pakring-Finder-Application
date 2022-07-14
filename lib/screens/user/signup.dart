import 'package:flutter/material.dart';
import 'package:park_locator/screens/user/login.dart';


import '../../Model/UserData.dart';
import '../../Network/API/UserAPi.dart';
import '../../Shared/Components.dart';
import '../../services/appprovider.dart';
import '../Home.dart';
import 'package:provider/provider.dart';

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var formKey = GlobalKey<FormState>();

  var firstNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: heightResponsive(
                      context: context,
                      height: 8,
                    )),
                Center(
                  child: Text(
                    "Sign-Up",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: heightResponsive(
                    context: context,
                    height: 20,
                  ),
                ),
                defaultTextFormField(
                  context: context,
                  controller: firstNameController,
                  type: TextInputType.name,
                  label: "Name",
                  messageValidate: "name cant be empty",
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: Colors.blueGrey,

                  ),
                ),
                SizedBox(
                  height: heightResponsive(
                    context: context,
                    height: 30,
                  ),
                ),
                defaultTextFormField(
                  context: context,
                  controller: phoneController,
                  type: TextInputType.phone,
                  label: "phoneNumber",
                  messageValidate: "error",
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: heightResponsive(
                    context: context,
                    height: 30,
                  ),
                ),
                defaultTextFormField(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.blueGrey,
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
                    height: 30,
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
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: heightResponsive(
                    context: context,
                    height: 30,
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                    child: Text("Sign up",),
                    onPressed: () async {
                      String number = "+2" + phoneController.text;

                      if (formKey.currentState.validate()) {
                        String returnValue;
                        returnValue = await signupApi(
                            email: emailController.text,
                            password: passwordController.text,
                            name: firstNameController.text,
                            number: number);
                        if (returnValue == "Sign Up Successful") {
                          showDialog(context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(
                                    title:  Text("Success",style: TextStyle(color:Colors.blueGrey),),
                                    content:  Text(returnValue,style: TextStyle(color:Colors.blueGrey),),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            navigateTo(context,login()),
                                        child: const Text('Login',style: TextStyle(color:Colors.black),),
                                      ),  TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context,'Cancel'),
                                        child: const Text('Cancel',style: TextStyle(color:Colors.black),),
                                      ),
                                    ],
                                  ));
                        }
                        else {
                          showDialog(context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(

                                        title:  Text("Failed to sign up", style: TextStyle(
                                            color: Colors.red
                                        ),),
                                        content:  Text(returnValue, style: TextStyle(
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

                    }
                  ),
                ),
              Row(
                children:[
                  Text("Already have account ? "),
          TextButton(
              onPressed:()
              {
                navigateTo(context, login());
              }
              , child:Text('Log in',style: TextStyle(color:Colors.blueGrey),),  ),
                ]

              ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}