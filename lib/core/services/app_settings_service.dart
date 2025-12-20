import 'package:shared_preferences/shared_preferences.dart';

/// Service to handle app settings persistence using SharedPreferences.
/// Manages theme and locale preferences.
class AppSettingsService {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _localeCodeKey = 'localeCode';

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
}
