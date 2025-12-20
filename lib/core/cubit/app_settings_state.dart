part of 'app_settings_cubit.dart';

@immutable
class AppSettingsState {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettingsState({
    this.themeMode = ThemeMode.light,
    this.locale = const Locale('ar', 'AR'),
  });

  AppSettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppSettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }
}
