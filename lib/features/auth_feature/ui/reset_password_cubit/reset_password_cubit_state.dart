part of 'reset_password_cubit_cubit.dart';

@immutable
sealed class ResetPasswordCubitState {}

final class ResetPasswordCubitInitial extends ResetPasswordCubitState {}

class ResetPasswordCubitLoading extends ResetPasswordCubitState {}

class ResetPasswordCubitSuccess extends ResetPasswordCubitState {
  final ResetPasswordEntity userPassword;

  ResetPasswordCubitSuccess(this.userPassword);
}

class ResetPasswordCubitFailure extends ResetPasswordCubitState {
  final String errorMessage;

  ResetPasswordCubitFailure(this.errorMessage);
}
