part of 'products_cubit.dart';

sealed class ProductsState {}

// GetStoreProductsWithFilter
final class ProductsInitial extends ProductsState {}

final class ProductsLoadInProgress extends ProductsState {}

final class ProductsLoadFailure extends ProductsState {
  final String errMessage;

  ProductsLoadFailure(this.errMessage);
}

final class ProductsLoadSuccess extends ProductsState {
  final List<ProductEntity> products;
  final List<ProductEntity> selectedProducts; // [states for Check boxes]

  ProductsLoadSuccess(
    this.products,
    this.selectedProducts,
  );
}

/// for pagination

// final class GetStoreProductsWithFilterPaginationLoadging
//     extends ProductsState {}

// final class GetStoreProductsWithFilterPaginationFaliure extends ProductsState {
//   final String errMessage;

//   GetStoreProductsWithFilterPaginationFaliure({required this.errMessage});
// }

// sealed class WeatherState {
//   const WeatherState();
// }

// final class WeatherInitial extends WeatherState {
//   const WeatherInitial();
// }

// final class WeatherLoadInProgress extends WeatherState {
//   const WeatherLoadInProgress();
// }

// final class WeatherLoadSuccess extends WeatherState {
//   const WeatherLoadSuccess({required this.weather});
//   final Weather weather;
// }

// final class WeatherLoadFailure extends WeatherState {
//   const WeatherLoadFailure({required this.exception});
//   final Exception exception;
// }
