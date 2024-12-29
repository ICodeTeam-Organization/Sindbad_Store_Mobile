part of 'disable_products_by_ids_cubit.dart';

sealed class DisableProductsByIdsState {
  const DisableProductsByIdsState();
}

final class DisableProductsByIdsInitial extends DisableProductsByIdsState {}

final class DisableProductsByIdsLoading extends DisableProductsByIdsState {}

final class DisableProductsByIdsSuccess extends DisableProductsByIdsState {
  final DisableProductsEntity message;

  DisableProductsByIdsSuccess({required this.message});
}

final class DisableProductsByIdsFailure extends DisableProductsByIdsState {
  final String errMessage;

  DisableProductsByIdsFailure({required this.errMessage});
}
