import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

sealed class SigninState {}

final class SigninInitial extends SigninState {}

class SigninLoadInProgress extends SigninState {}

class SigninSuccess extends SigninState {
  SigninSuccess();
}

class SigninLoadFailure extends SigninState {
  final String errorMessage;

  SigninLoadFailure(this.errorMessage);
}
/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}