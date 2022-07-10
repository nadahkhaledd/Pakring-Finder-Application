import 'package:flutter/material.dart';

double heightResponsive({
  @required BuildContext context,
  @required double height,
}) =>
    MediaQuery.of(context).size.height / height;

double widthResponsive({
  @required BuildContext context,
  @required double width,
}) =>
    MediaQuery.of(context).size.width / width;

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (Route<dynamic> route) => false,
);

Widget defaultTextFormField({
  Color borderColor = Colors.blue,
  Color fontColor = const Color(0xff5F5E64),
  double fontSize = 16,
  @required BuildContext context,
  double width = double.infinity,
  @required TextEditingController controller,
  @required TextInputType type,
  String label,
  @required String messageValidate,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isClickable = true,
  bool isPassword = false,
  bool readOnly = false,
  Icon prefixIcon,
  Icon suffixIcon,
  Function onPressSuffixIcon,
}) =>
    Container(
      width: width == double.infinity
          ? double.infinity
          : widthResponsive(
        context: context,
        width: width,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.zero,
      ),
      child: TextFormField(
        readOnly: readOnly,
        enabled: isClickable,
        controller: controller,
        obscureText: isPassword,
        keyboardType: type,
        style: TextStyle(
          fontSize: 15,
          color: const Color(0xff5F5E64),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return messageValidate;
          }
          return null;
        },
        onFieldSubmitted: (value) {
          if (onSubmit != null) {
            onSubmit(value);
          }
        },
        onChanged: (value) {
          if (onChange != null) {
            onChange(value);
          }
        },
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon ?? null,
          suffixIcon: suffixIcon != null
              ? IconButton(
            onPressed: () {
              onPressSuffixIcon();
            },
            icon: suffixIcon,
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:  Colors.blueGrey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            color: const Color(0xff5F5E64),
          ),


        ),
      ),
    );