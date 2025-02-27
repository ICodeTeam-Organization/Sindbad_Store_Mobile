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
  final List<bool> checkedStates; // [states for Check boxes]
  final List<int> productsSelected; // [IDs for products selected]

  GetStoreProductsWithFilterSuccess(
      this.products, this.checkedStates, this.productsSelected);
}

/// for pagination

final class GetStoreProductsWithFilterPaginationLoadging extends GetStoreProductsWithFilterState {}

final class GetStoreProductsWithFilterPaginationFaliure extends GetStoreProductsWithFilterState {
  final String errMessage;

  GetStoreProductsWithFilterPaginationFaliure({required this.errMessage});
}