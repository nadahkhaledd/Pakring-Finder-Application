import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container loadingIndicator(context, String text)
{
  return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 1/10,
      width: MediaQuery.of(context).size.width * 2/3,
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.black45,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
          )),
          Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(color: Colors.blueGrey),
          ))
        ],
      )
  );
}