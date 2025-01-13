part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsEntity productDetailsEntity;

  ProductDetailsSuccess({required this.productDetailsEntity});
}

final class ProductDetailsFailure extends ProductDetailsState {
  final String errMessage;

  ProductDetailsFailure({required this.errMessage});
}
