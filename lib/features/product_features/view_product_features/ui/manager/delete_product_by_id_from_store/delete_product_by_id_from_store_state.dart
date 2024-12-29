part of 'delete_product_by_id_from_store_cubit.dart';

sealed class DeleteProductByIdFromStoreState {
  const DeleteProductByIdFromStoreState();
}

final class DeleteProductByIdFromStoreInitial
    extends DeleteProductByIdFromStoreState {}

final class DeleteProductByIdFromStoreLoading
    extends DeleteProductByIdFromStoreState {}

final class DeleteProductByIdFromStoreFailure
    extends DeleteProductByIdFromStoreState {
  final String errMessage;

  DeleteProductByIdFromStoreFailure({required this.errMessage});
}

final class DeleteProductByIdFromStoreSuccess
    extends DeleteProductByIdFromStoreState {
  final String message;

  DeleteProductByIdFromStoreSuccess({required this.message});
}
