import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_products_parames.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_products_usecase.dart';

part 'products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProductsUseCase) : super(ProductsInitial());
  final GetProductsUseCase getProductsUseCase;

  List<ProductEntity> allProducts = [];

  List<int> updatedProductsSelected = [];

  // used for refreshing the list
  int? currentStoreProductsFilter;
  int? currentMainCategoryId;

  // fun to refresh checkbox state
  void updateCheckboxState(int index, bool value, int productId) {
    if (state is ProductsLoadSuccess) {
      final currentState = state as ProductsLoadSuccess;
      final List<bool> updatedCheckedStates =
          List<bool>.from(currentState.checkedStates);
      updatedProductsSelected = List<int>.from(currentState.productsSelected);
      updatedCheckedStates[index] = value;
      value
          ? updatedProductsSelected.add(productId)
          : updatedProductsSelected.remove(productId);
      debugPrint('==== After checkbox update: $updatedProductsSelected');
      emit(ProductsLoadSuccess(
        currentState.products,
        updatedCheckedStates,
        updatedProductsSelected,
      ));
    }
  }

  Future<void> getStoreProductsWitheFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    int? categoryId,
  }) async {
    if (pageNumber == 1) {
      allProducts.clear();
    }
    emit(ProductsLoadInProgress());
    currentStoreProductsFilter = storeProductsFilter;
    currentMainCategoryId = categoryId;

    var params = ProductsParams(storeProductsFilter, pageNumber, pageSize);
    var result = await getProductsUseCase.execute(params);

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(ProductsLoadFailure(failure.message));
        } else {
          emit(ProductsLoadSuccess(
            allProducts,
            List<bool>.filled(allProducts.length, false),
            [],
          ));
        }
      },
      (fetchedProducts) {
        if (pageNumber == 1) {
          allProducts = fetchedProducts;
        } else {
          allProducts.addAll(fetchedProducts);
        }
        emit(ProductsLoadSuccess(
          allProducts,
          List<bool>.filled(allProducts.length, false),
          [],
        ));
      },
    );
  }

  Future<void> getProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());

    if (pageNumber == 1) {
      allProducts.clear();
    }

    var params = ProductsParams(pageNumber, pageSize, 0);
    var result = await getProductsUseCase.execute(params);

    result.fold((failure) {
      if (pageNumber == 1) {
        emit(ProductsLoadFailure(failure.message));
      } else {
        emit(ProductsLoadSuccess(
          allProducts,
          List<bool>.filled(allProducts.length, false),
          [],
        ));
      }
    }, (fetchedProducts) {
      if (pageNumber == 1) {
        allProducts = fetchedProducts;
      } else {
        allProducts.addAll(fetchedProducts);
      }

      emit(ProductsLoadSuccess(
        allProducts,
        List<bool>.filled(allProducts.length, false),
        [],
      ));
    });
  }
}
