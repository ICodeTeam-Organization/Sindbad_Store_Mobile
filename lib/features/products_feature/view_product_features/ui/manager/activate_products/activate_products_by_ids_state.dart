part of 'activate_products_by_ids_cubit.dart';

sealed class ActivateProductsByIdsState {
  const ActivateProductsByIdsState();
}

final class ActivateProductsByIdsInitial extends ActivateProductsByIdsState {}

final class ActivateProductsByIdsLoading extends ActivateProductsByIdsState {}

final class ActivateProductsByIdsSuccess extends ActivateProductsByIdsState {
  final ActivateProductsEntity message;

  ActivateProductsByIdsSuccess({required this.message});
}

final class ActivateProductsByIdsFailure extends ActivateProductsByIdsState {
  final String errMessage;

  ActivateProductsByIdsFailure({required this.errMessage});
}
