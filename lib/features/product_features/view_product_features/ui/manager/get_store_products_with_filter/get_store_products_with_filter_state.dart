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
  final List<int> productsSelected; // المنتجات المختارة من check box

  GetStoreProductsWithFilterSuccess(
      this.products, this.checkedStates, this.productsSelected);
}
