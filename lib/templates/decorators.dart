import 'package:flutter/material.dart';

BoxDecoration textBoxDecoration = BoxDecoration(
    color: Colors.white60, borderRadius: BorderRadius.circular(10));

InputDecoration inputDecoration(text) {
  return InputDecoration(
    label: Text(text),
    border: InputBorder.none,
  );
}
