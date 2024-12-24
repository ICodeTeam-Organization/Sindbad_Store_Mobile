part of 'get_store_products_with_filter_cubit.dart';

sealed class GetStoreProductsWithFilterState {}

// GetStoreProductsWithFilter
final class GetStoreProductsWithFilterInitial
    extends GetStoreProductsWithFilterState {}

final class GetStoreProductsWithFilterLoading
    extends GetStoreProductsWithFilterState {}

final class GetStoreProductsWithFilterFailure
    extends GetStoreProductsWithFilterState {
  final String errMessage;

  GetStoreProductsWithFilterFailure(this.errMessage);
}

final class GetStoreProductsWithFilterSuccess
    extends GetStoreProductsWithFilterState {
  final List<ProductEntity> products;
  final List<bool> checkedStates; // الحالة الخاصة بكل Checkbox
  final List<String> productsSelected; // المنتجات المختارة من check box

  GetStoreProductsWithFilterSuccess(
      this.products, this.checkedStates, this.productsSelected);
}

// Delete Product By Id
final class DeleteStoreProductByIdLoading
    extends GetStoreProductsWithFilterState {}

final class DeleteStoreProductByIdFailure
    extends GetStoreProductsWithFilterState {
  final String errMessage;

  DeleteStoreProductByIdFailure({required this.errMessage});
}

final class DeleteStoreProductByIdSuccess
    extends GetStoreProductsWithFilterState {
  final DeleteProductEntity message;

  DeleteStoreProductByIdSuccess({required this.message});
}
