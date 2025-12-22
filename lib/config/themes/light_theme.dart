import 'package:flutter/material.dart';

class LightTheme {
  LightTheme._(); // Private constructor to prevent instantiation

  // Color constants for light theme
  static const Color _primaryColor =
      Color(0xFFFF746B); // Coral/salmon - AppColors.primary
  static const Color _textPrimary = Colors.black;
  static const Color _textSecondary = Color(0xFF636773);
  static const Color _textHint = Color(0xFF979797);

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

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: _textPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: _textPrimary),
      titleTextStyle: TextStyle(
        fontFamily: 'Cairo',
        color: _textPrimary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),

    // Icon theme
    iconTheme: const IconThemeData(
      color: _textPrimary,
      size: 24,
    ),

    // Text theme with Cairo font
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: _textPrimary,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        fontSize: 28,
        color: _textPrimary,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: _textPrimary,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: _textPrimary,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: _textPrimary,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: _textPrimary,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: _textPrimary,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: _textPrimary,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: _textPrimary,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: _textPrimary,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: _textPrimary,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: _textSecondary,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: _textPrimary,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: _textSecondary,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w400,
        fontSize: 10,
        color: _textHint,
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: const TextStyle(fontFamily: 'Cairo', color: _textHint),
      labelStyle: const TextStyle(fontFamily: 'Cairo', color: _textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryColor),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontFamily: 'Cairo'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
