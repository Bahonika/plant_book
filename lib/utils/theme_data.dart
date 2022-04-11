import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: const Color.fromRGBO(214, 244, 200, 1),
    backgroundColor: const Color.fromRGBO(214, 244, 200, 1),
    primaryColor: const Color.fromRGBO(75, 121, 55, 1.0),
    canvasColor: const Color.fromRGBO(187, 197, 177, 1),
    // textTheme: TextTheme(bodyText1: GoogleFonts.montserrat()),
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(onPrimary: Colors.black54)
        .copyWith(primaryContainer: const Color.fromRGBO(245, 245, 245, 0.6))
        .copyWith(primary: const Color.fromRGBO(75, 121, 55, 1.0))
        .copyWith(secondary: const Color.fromRGBO(62, 151, 139, 1)));
