part of 'edit_product_from_store_cubit.dart';

sealed class EditProductFromStoreState {}

//
final class EditProductFromStoreInitial extends EditProductFromStoreState {}

final class EditProductFromStoreLoading extends EditProductFromStoreState {}

final class EditProductFromStoreSuccess extends EditProductFromStoreState {
  final EditProductEntity message;

  EditProductFromStoreSuccess({required this.message});
}

final class EditProductFromStoreFailure extends EditProductFromStoreState {
  final String errMessage;

  EditProductFromStoreFailure({required this.errMessage});
}
