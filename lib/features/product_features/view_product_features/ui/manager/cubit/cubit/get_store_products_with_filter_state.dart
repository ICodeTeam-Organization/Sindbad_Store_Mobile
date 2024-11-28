part of 'get_store_products_with_filter_cubit.dart';

@immutable
sealed class GetStoreProductsWithFilterState {}

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

  GetStoreProductsWithFilterSuccess(this.products, this.checkedStates);
}
