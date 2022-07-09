

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class customWidgets {
  static Widget textField(String title,String hint,
      {bool isPassword = false,
        bool isNumber = false,

        int length,
        TextEditingController textController,
        int lines = 1}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            TextFormField(
              maxLines: lines,
              controller: textController,
              maxLength: length,
              inputFormatters: [
                LengthLimitingTextInputFormatter(length),
              ],
              obscureText: isPassword,
              keyboardType: isNumber ? TextInputType.number : TextInputType.text,
              decoration: InputDecoration(
                hintText: hint,
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            )
          ],
        ),
      ),
    );
  }
}