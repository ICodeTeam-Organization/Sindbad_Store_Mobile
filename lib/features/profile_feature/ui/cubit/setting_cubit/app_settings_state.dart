part of 'app_settings_cubit.dart';

/// Base class for all app settings states.
sealed class SettingsState {}

/// Initial state before settings are loaded.
class SettingsInitial extends SettingsState {}

/// State while settings are being loaded.
class SettingsLoadInProgress extends SettingsState {}

/// State when settings are successfully loaded.
class SettingsLoadSuccess extends SettingsState {}

/// State when loading settings failed.
class SettingsLoadFailure extends SettingsState {
  final String message;
  SettingsLoadFailure(this.message);
}

/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}
