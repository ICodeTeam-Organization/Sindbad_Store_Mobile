import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/services/app_settings_service.dart';

part 'app_settings_state.dart';

/// Cubit to manage app-wide settings: theme and locale.
/// Uses AppSettingsService for persistence via SharedPreferences.
class AppSettingsCubit extends Cubit<AppSettingsState> {
  final AppSettingsService settingsService;

  AppSettingsCubit(this.settingsService) : super(const AppSettingsState());

  /// Loads saved settings on app startup.
  Future<void> loadSettings() async {
    final isDarkMode = await settingsService.loadIsDarkMode();
    final localeCode = await settingsService.loadLocaleCode();

    emit(AppSettingsState(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(localeCode),
    ));
  }

  /// Toggles between light and dark theme modes.
  Future<void> toggleTheme() async {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await settingsService.saveIsDarkMode(newMode == ThemeMode.dark);
    emit(state.copyWith(themeMode: newMode));
  }

  /// Sets the app locale.
  Future<void> setLocale(Locale locale) async {
    await settingsService.saveLocaleCode(locale.languageCode);
    emit(state.copyWith(locale: locale));
  }

  /// Returns true if current theme is dark mode.
  bool get isDarkMode => state.themeMode == ThemeMode.dark;

  /// Returns the current locale code (e.g., 'ar', 'en').
  String get localeCode => state.locale.languageCode;
}
