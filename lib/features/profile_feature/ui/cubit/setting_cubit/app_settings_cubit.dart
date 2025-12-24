import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/services/app_settings_service.dart';

part 'app_settings_state.dart';

/// Cubit to manage app-wide settings: theme, locale, and pay later.
/// Data is stored as properties, accessed via context.watch<AppSettingsCubit>().
/// State only represents loading status (Initial, Loading, Loaded, Error).
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsService _settingsService;

  // Settings stored as properties - accessed via context.watch
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('ar', 'AR');
  bool isPayLaterEnabled = false;

  SettingsCubit(this._settingsService) : super(SettingsInitial());

  /// Loads saved settings on app startup.
  Future<void> loadSettings() async {
    emit(SettingsLoadInProgress());
    try {
      final isDarkMode = await _settingsService.loadIsDarkMode();
      final localeCode = await _settingsService.loadLocaleCode();
      final payLater = await _settingsService.loadIsPayLaterEnabled();

      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      locale = Locale(localeCode);
      isPayLaterEnabled = payLater;

      emit(SettingsLoadSuccess());
    } catch (e) {
      emit(SettingsLoadFailure(e.toString()));
    }
  }

  /// Toggles between light and dark theme modes.
  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _settingsService.saveIsDarkMode(themeMode == ThemeMode.dark);
    emit(SettingsLoadSuccess()); // Re-emit to trigger rebuild
  }

  /// Sets the app locale.
  Future<void> setLocale(Locale newLocale) async {
    locale = newLocale;
    await _settingsService.saveLocaleCode(newLocale.languageCode);
    emit(SettingsLoadSuccess()); // Re-emit to trigger rebuild
  }

  /// Toggles pay later setting.
  Future<void> togglePayLater() async {
    isPayLaterEnabled = !isPayLaterEnabled;
    await _settingsService.saveIsPayLaterEnabled(isPayLaterEnabled);
    emit(SettingsLoadSuccess()); // Re-emit to trigger rebuild
  }

  /// Clears all user settings (for logout).
  Future<void> clearAllSettings() async {
    await _settingsService.clearAllSettings();
    // Reset to defaults
    themeMode = ThemeMode.light;
    locale = const Locale('ar', 'AR');
    isPayLaterEnabled = false;
    emit(SettingsLoadSuccess());
  }

  /// Returns true if current theme is dark mode.
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Returns the current locale code (e.g., 'ar', 'en').
  String get localeCode => locale.languageCode;
}
