import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle app settings persistence using SharedPreferences.
/// Manages theme, locale, and pay later preferences.
class AppSettingsService {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _localeCodeKey = 'localeCode';
  static const String _isPayLaterEnabledKey = 'isPayLaterEnabled';

  /// Loads the saved dark mode preference.
  Future<bool> loadIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  /// Saves the dark mode preference.
  Future<void> saveIsDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDark);
  }

  /// Loads the saved locale code (e.g., 'ar', 'en').
  Future<String> loadLocaleCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_localeCodeKey) ?? 'ar'; // Default to Arabic
  }

  /// Saves the locale code.
  Future<void> saveLocaleCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeCodeKey, code);
  }

  /// Loads the saved pay later preference.
  Future<bool> loadIsPayLaterEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isPayLaterEnabledKey) ?? false;
  }

  /// Saves the pay later preference.
  Future<void> saveIsPayLaterEnabled(bool isEnabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isPayLaterEnabledKey, isEnabled);
  }

  /// Clears all user settings (for logout).
  Future<void> clearAllSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isDarkModeKey);
    await prefs.remove(_localeCodeKey);
    await prefs.remove(_isPayLaterEnabledKey);
  }
}
