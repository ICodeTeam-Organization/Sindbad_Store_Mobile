sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoadInProgress extends ForgetPasswordState {}

final class ForgetPasswordLoadSuccess extends ForgetPasswordState {}

final class ForgetPasswordLoadFailure extends ForgetPasswordState {
  final String errorMessage;

  ForgetPasswordLoadFailure(this.errorMessage);
}
