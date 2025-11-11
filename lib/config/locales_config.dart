import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class LocalesConfig {
  static const List<Locale> supportedLocales = [
    Locale('ar', 'AR'), // Arabic, no country code
    // Add more locales here as needed
    // Locale('en', 'US'),
    // Locale('fr', 'FR'),
  ];

  static const Locale defaultLocale = Locale('ar', 'AR');

  static final List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // Add your app-specific delegates here if needed
    // AppLocalizations.delegate,
  ];
}
