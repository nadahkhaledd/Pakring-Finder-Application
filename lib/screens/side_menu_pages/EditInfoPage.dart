import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Network/API/UserAPi.dart';
import '../../services/appprovider.dart';
import '../../widgets/Appdrawer.dart';
import 'package:park_locator/widgets/d_widgets/customWidgets.dart';

class EditInfoPage extends StatefulWidget{

  String name;
  String email;
  String number;
  String password="";
  EditInfoPage(this.name, this.email, this.number);
  @override
  State<EditInfoPage> createState() => _EditInfoPageState();
}

class _EditInfoPageState extends State<EditInfoPage> {
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              TextFormField(
                maxLines: 1,
                onChanged: (value){
                  setState(() {
                    widget.email=value;
                  });

                },
                decoration: InputDecoration(
                    hintText: provider.currentUser.email,
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
              Text(
                'name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              TextFormField(
                maxLines: 1,
                onChanged: (value){
                  setState(() {
                    widget.name=value;
                  });
                },
                decoration: InputDecoration(
                    hintText: provider.currentUser.name,
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
              Text(
                'Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              TextFormField(
                maxLines: 1,
                onChanged: (value){
                  setState(() {
                    widget.password=value;
                  });
                },
                decoration: InputDecoration(
                    hintText: "",
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
              Text(
                'Number',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),

              TextFormField(
                maxLines: 1,
                onChanged: (value){
                  setState(() {
                    widget.number=value;
                  });
                },
                decoration: InputDecoration(
                    hintText: provider.currentUser.number,
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Center(
                  child: FloatingActionButton.extended(
                    onPressed: (){
                      setState(() {
                        editUserInfo(provider.currentUser.token,provider.currentUser.id,widget.name,widget.email,widget.number,"",widget.password);

                        final snackBar = SnackBar(content:  Text("info updated"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                      // print(widget.name);
                      // print(widget.email);
                      // print(widget.number);
                      // print(widget.password);
                      //Navigator.pop(context);


                    },
                    label: Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                    backgroundColor: Colors.blueGrey,),
                ),
              )

            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}