import 'package:flutter/material.dart';


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
                      height: 6,
                    )),
                Center(
                  child: Text(
                    "Sign-Up",
                    style: TextStyle(
                        color: Colors.blue,
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
                    onPressed: () async {
                      String number = "+2" + phoneController.text;

                      if (formKey.currentState.validate()) {
                        userData user;

                        user = await signupApi(
                            email: emailController.text,
                            password: passwordController.text,
                            name: firstNameController.text,
                            number: number);
                        provider.updateUser(user);

                        navigateTo(context, (){});
                      }
                    },
                    child: Text("Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}