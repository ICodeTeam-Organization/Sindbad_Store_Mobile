part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoadInProgress extends ResetPasswordState {}

class ResetPasswordLoadSuccess extends ResetPasswordState {
  final ResetPasswordEntity userPassword;

  ResetPasswordLoadSuccess(this.userPassword);
}

class ResetPasswordLoadFailure extends ResetPasswordState {
  final String errorMessage;

  ResetPasswordLoadFailure(this.errorMessage);
}


/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}