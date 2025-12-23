import 'package:flutter/material.dart';

class DarkTheme {
  DarkTheme._(); // Private constructor

  // Color constants for dark theme
  static const Color _primaryColor =
      Color(0xFFD8433E); // Darker red for dark theme
  static const Color _backgroundColor = Color(0xFF121212);
  static const Color _surfaceColor = Color(0xFF1E1E1E);
  static const Color _cardColor = Color(0xFF2C2C2C);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFFB3B3B3);
  static const Color _textHint = Color(0xFF757575);

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Cairo',
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _backgroundColor,

    // Card and surface colors
    cardColor: _cardColor,
    canvasColor: _surfaceColor,

    // Color scheme
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: _primaryColor,
      surface: _surfaceColor,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: _textPrimary,
    ),

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: _surfaceColor,
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

    // Chip theme
    chipTheme: ChipThemeData(
      backgroundColor: _surfaceColor,
      labelStyle: const TextStyle(color: _textPrimary),
      secondaryLabelStyle: const TextStyle(color: _textSecondary),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    // List tile theme
    listTileTheme: const ListTileThemeData(
      textColor: _textPrimary,
      iconColor: _textSecondary,
    ),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: Color(0xFF404040),
      thickness: 1,
    ),

    // Text theme
    textTheme: const TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 32,
        color: _textPrimary,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 28,
        color: _textPrimary,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: _textPrimary,
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: _textPrimary,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: _textPrimary,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: _textPrimary,
      ),

      // Title styles
      titleLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: _textPrimary,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: _textPrimary,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: _textPrimary,
      ),

      // Body styles
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: _textPrimary,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: _textPrimary,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: _textSecondary,
      ),

      // Label styles
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: _textPrimary,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: _textSecondary,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10,
        color: _textHint,
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: _surfaceColor,
      filled: true,
      hintStyle: const TextStyle(color: _textHint),
      labelStyle: const TextStyle(color: _textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF404040)),
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _primaryColor;
        }
        return _textSecondary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _primaryColor.withOpacity(0.5);
        }
        return _surfaceColor;
      }),
    ),
  );
}
