part of 'app_settings_cubit.dart';

/// Base class for all app settings states.
sealed class AppSettingsState {}

/// Initial state before settings are loaded.
class AppSettingsInitial extends AppSettingsState {}

/// State while settings are being loaded.
class AppSettingsLoading extends AppSettingsState {}

/// State when settings are successfully loaded.
class AppSettingsLoaded extends AppSettingsState {}

/// State when loading settings failed.
class AppSettingsError extends AppSettingsState {
  final String message;
  AppSettingsError(this.message);
}
