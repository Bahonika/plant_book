import 'package:flutter/material.dart';

List<BoxShadow> boxShadow(BuildContext context) {
  return [
    const BoxShadow(
      color: Color.fromRGBO(96, 154, 76, 0.5),
    ),
    BoxShadow(
      color: Theme.of(context).backgroundColor,
      spreadRadius: -12.0,
      blurRadius: 150.0,
    )
  ];
}
