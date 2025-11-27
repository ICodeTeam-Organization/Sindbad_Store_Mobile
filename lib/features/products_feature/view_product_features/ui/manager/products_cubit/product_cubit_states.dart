import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoadInProgress extends ProductsState {}

class ProductsLoadSuccess extends ProductsState {
  final List<ProductEntity> products;
  ProductsLoadSuccess(this.products);
}

class ProductsLoadFailure extends ProductsState {
  final String message;
  ProductsLoadFailure(this.message);
}
