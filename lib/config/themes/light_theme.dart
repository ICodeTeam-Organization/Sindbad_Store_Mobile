import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._(); // Private constructor to prevent instantiation

  // Color constants for light theme
  static const Color _primaryColor =
      Color(0xFFFF746B); // Coral/salmon - AppColors.primary

  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Cairo',
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,

    // Color scheme
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _primaryColor,
      surface: Colors.white,
      background: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: 'Cairo', // font-family
        fontWeight: FontWeight.w700, // font-weight: 700
        fontStyle: FontStyle.normal, // Bold is handled by fontWeight
        fontSize: 12, // font-size in pixels
        height: 1.0, // line-height: 100%
        letterSpacing: 0.27, // letter-spacing
      ),
      titleMedium: TextStyle(
        fontFamily: 'Cairo', // font-family
        fontWeight: FontWeight.w700, // font-weight: 700
        fontStyle: FontStyle.normal, // Bold is handled by fontWeight
        fontSize: 12, // font-size in pixels
        height: 1.0, // line-height: 100%
        letterSpacing: 0.27, // letter-spacing
      ),
      titleSmall: TextStyle(
          fontFamily: 'Cairo', // font-family
          fontWeight: FontWeight.w700, // font-weight: 700
          fontStyle: FontStyle.normal, // Bold is handled by fontWeight
          fontSize: 14, // font-size in pixels
          height: 1.0, // line-height: 100%
          letterSpacing: 0.27,
          color: Colors.white // letter-spacing
          ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo', // font-family
        fontWeight: FontWeight.w700, // font-weight: 700
        fontStyle: FontStyle.normal, // Bold is handled by fontWeight
        fontSize: 10, // font-size in pixels
        height: 1.0, // line-height: 100%
        letterSpacing: 0.27, // letter-spacing
      ),
      // bodyText1: TextStyle(
      //   fontWeight: FontWeight.w700,
      //   fontSize: 12,
      //   height: 1.0,
      //   letterSpacing: 0.27,
      //   color: Colors.black,
      // ),
      // bodyText2: TextStyle(
      //   fontWeight: FontWeight.w400,
      //   fontSize: 14,
      //   height: 1.2,
      //   letterSpacing: 0.25,
      //   color: Colors.black,
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
