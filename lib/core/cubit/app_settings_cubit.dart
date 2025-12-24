import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/services/app_settings_service.dart';

part 'app_settings_state.dart';

/// Cubit to manage app-wide settings: theme, locale, and pay later.
/// Data is stored as properties, accessed via context.watch<AppSettingsCubit>().
/// State only represents loading status (Initial, Loading, Loaded, Error).
class AppSettingsCubit extends Cubit<AppSettingsState> {
  final AppSettingsService settingsService;

  // Settings stored as properties - accessed via context.watch
  ThemeMode themeMode = ThemeMode.light;
  Locale locale = const Locale('ar', 'AR');
  bool isPayLaterEnabled = false;

  AppSettingsCubit(this.settingsService) : super(AppSettingsInitial());

  /// Loads saved settings on app startup.
  Future<void> loadSettings() async {
    emit(AppSettingsLoading());
    try {
      final isDarkMode = await settingsService.loadIsDarkMode();
      final localeCode = await settingsService.loadLocaleCode();
      final payLater = await settingsService.loadIsPayLaterEnabled();

      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
      locale = Locale(localeCode);
      isPayLaterEnabled = payLater;

      emit(AppSettingsLoaded());
    } catch (e) {
      emit(AppSettingsError(e.toString()));
    }
  }

  /// Toggles between light and dark theme modes.
  Future<void> toggleTheme() async {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await settingsService.saveIsDarkMode(themeMode == ThemeMode.dark);
    emit(AppSettingsLoaded()); // Re-emit to trigger rebuild
  }

  /// Sets the app locale.
  Future<void> setLocale(Locale newLocale) async {
    locale = newLocale;
    await settingsService.saveLocaleCode(newLocale.languageCode);
    emit(AppSettingsLoaded()); // Re-emit to trigger rebuild
  }

  /// Toggles pay later setting.
  Future<void> togglePayLater() async {
    isPayLaterEnabled = !isPayLaterEnabled;
    await settingsService.saveIsPayLaterEnabled(isPayLaterEnabled);
    emit(AppSettingsLoaded()); // Re-emit to trigger rebuild
  }

  /// Clears all user settings (for logout).
  Future<void> clearAllSettings() async {
    await settingsService.clearAllSettings();
    // Reset to defaults
    themeMode = ThemeMode.light;
    locale = const Locale('ar', 'AR');
    isPayLaterEnabled = false;
    emit(AppSettingsLoaded());
  }

  /// Returns true if current theme is dark mode.
  bool get isDarkMode => themeMode == ThemeMode.dark;

  /// Returns the current locale code (e.g., 'ar', 'en').
  String get localeCode => locale.languageCode;
}
