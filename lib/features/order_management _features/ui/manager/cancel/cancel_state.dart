part of 'cancel_cubit.dart';

@immutable
sealed class CancelState {}

final class CancelInitial extends CancelState {}

final class CancelLoading extends CancelState {}

final class CancelFailure extends CancelState {
  final String errMessage;

  CancelFailure({required this.errMessage});
}

final class CancelSuccess extends CancelState {
  final OrderCancelEntity serverMessage;

  CancelSuccess({required this.serverMessage});
}
