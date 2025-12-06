sealed class ConfirmPasswordState {}

final class ConfirmPasswordInitial extends ConfirmPasswordState {}

class ConfirmPasswordLoadInProgress extends ConfirmPasswordState {}

class ConfirmPasswordSuccess extends ConfirmPasswordState {
  ConfirmPasswordSuccess();
}

class ConfirmPasswordLoadFailure<T> extends ConfirmPasswordState {
  final T? error;

  ConfirmPasswordLoadFailure(this.error);
}
/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}