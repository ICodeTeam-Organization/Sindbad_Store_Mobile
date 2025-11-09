import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

sealed class ConfirmPasswordState {}

final class ConfirmPasswordInitial extends ConfirmPasswordState {}

class ConfirmPasswordLoadInProgress extends ConfirmPasswordState {}

class ConfirmPasswordSuccess extends ConfirmPasswordState {
  ConfirmPasswordSuccess();
}

class ConfirmPasswordLoadFailure extends ConfirmPasswordState {
  final String errorMessage;

  ConfirmPasswordLoadFailure(this.errorMessage);
}
/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}