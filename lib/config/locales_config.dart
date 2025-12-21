import 'package:flutter/material.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';

class LocalesConfig {
  static const List<Locale> supportedLocales = [
    Locale('ar', 'AR'), // Arabic
    Locale('en', 'US'), // English
  ];

  static const Locale defaultLocale = Locale('ar', 'AR');

  /// Use AppLocalizations.localizationsDelegates which includes:
  /// - AppLocalizations.delegate
  /// - GlobalMaterialLocalizations.delegate
  /// - GlobalCupertinoLocalizations.delegate
  /// - GlobalWidgetsLocalizations.delegate
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      AppLocalizations.localizationsDelegates;
}
