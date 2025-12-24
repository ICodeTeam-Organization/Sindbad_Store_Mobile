part of 'drawer_cubit.dart';

/// Base class for all drawer states.
sealed class DrawerState {}

/// Initial state before profile is loaded.
class DrawerInitial extends DrawerState {}

/// State while profile is being loaded.
class DrawerLoading extends DrawerState {}

/// State when profile is successfully loaded.
class DrawerLoaded extends DrawerState {}

/// State when loading profile failed.
class DrawerError extends DrawerState {
  final String message;
  DrawerError(this.message);
}

/// State after successful logout.
class DrawerLoggedOut extends DrawerState {}
