import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._(); // Private constructor

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 12,
        height: 1.0,
        letterSpacing: 0.27,
        color: Colors.white,
      ),
      // bodyText1: TextStyle(
      //   fontWeight: FontWeight.w700,
      //   fontSize: 12,
      //   height: 1.0,
      //   letterSpacing: 0.27,
      //   color: Colors.white,
      // ),
      // bodyText2: TextStyle(
      //   fontWeight: FontWeight.w400,
      //   fontSize: 14,
      //   height: 1.2,
      //   letterSpacing: 0.25,
      //   color: Colors.white70,
      // ),
      // caption: TextStyle(
      //   fontWeight: FontWeight.w400,
      //   fontSize: 10,
      //   height: 1.0,
      //   letterSpacing: 0.2,
      //   color: Colors.grey,
      // ),
    ),
  );
}
