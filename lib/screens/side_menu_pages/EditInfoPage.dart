import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/appprovider.dart';
import '../../widgets/Appdrawer.dart';
import 'package:park_locator/widgets/d_widgets/customWidgets.dart';

class EditInfoPage extends StatelessWidget{
  AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          toolbarHeight: 70.0,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(65),
                  bottomRight: Radius.circular(65))),
          backgroundColor: Colors.blueGrey,
          title: Text(" Edit info "),
          centerTitle: true,
        ),
        drawer: Appdrawer(context),

        body: Column(
          children: [
            customWidgets.textField('Email',provider.currentUser.email),

            customWidgets.textField('Name',provider.currentUser.name),
            customWidgets.textField('Password',"", isPassword: true),
            customWidgets.textField('number',provider.currentUser.number, isNumber: true),
            FloatingActionButton.extended(
              onPressed: (){},
              label: Text(
              "Save",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
              backgroundColor: Colors.blueGrey,)

          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}