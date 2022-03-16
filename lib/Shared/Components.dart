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