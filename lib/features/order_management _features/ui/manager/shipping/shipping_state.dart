part of 'shipping_cubit.dart';

sealed class ShippingState {}

final class ShippingInitial extends ShippingState {}

final class ShippingLoading extends ShippingState {}

final class ShippingFailure extends ShippingState {
  final String errMessage;

  ShippingFailure({required this.errMessage});
}

final class ShippingSuccess extends ShippingState {
  final OrderShippingEntity serverMessage;

  ShippingSuccess({required this.serverMessage});
}
