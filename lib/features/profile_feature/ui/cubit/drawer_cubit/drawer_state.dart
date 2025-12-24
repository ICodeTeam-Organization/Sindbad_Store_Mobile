part of 'drawer_cubit.dart';

/// Base class for all drawer states.
sealed class DrawerState {}

/// Initial state before profile is loaded.
class DrawerInitial extends DrawerState {}

/// State while profile is being loaded.
class DrawerLoadInProgress extends DrawerState {}

/// State when profile is successfully loaded.
class DrawerLoadSuccess extends DrawerState {}

/// State when loading profile failed.
class DrawerLoadFailure extends DrawerState {
  final String message;
  DrawerLoadFailure(this.message);
}

/// State after successful logout.
class DrawerLoggedOut extends DrawerState {}


/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}