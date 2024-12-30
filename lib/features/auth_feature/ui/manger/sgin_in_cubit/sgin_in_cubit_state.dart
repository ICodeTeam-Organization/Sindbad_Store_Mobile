part of 'sgin_in_cubit_cubit.dart';

@immutable
sealed class SignInCubitState {}

final class SignInCubitInitial extends SignInCubitState {}

class SignInCubitLoading extends SignInCubitState {}

class SignInCubitSuccess extends SignInCubitState {
  final SignInEntity user;

  SignInCubitSuccess(this.user);
}

class SignInCubitFailure extends SignInCubitState {
  final String errorMessage;

  SignInCubitFailure(this.errorMessage);
}
