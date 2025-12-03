import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_products_parames.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_products_usecase.dart';

part 'products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProductsUseCase, this._disableProductsUseCase)
      : super(ProductsInitial());
  final GetProductsUseCase getProductsUseCase;
  final DisableProductsUseCase _disableProductsUseCase;

  List<ProductEntity> products = [];
  List<ProductEntity> selectedProducts = [];

  // List<int> updatedProductsSelected = [];

  // used for refreshing the list
  int? currentStoreProductsFilter;
  int? currentMainCategoryId;

  Future<void> stopSelectedProducts() async {
    // emit(ProductsLoadInProgress());

    var result = await _disableProductsUseCase
        .execute(selectedProducts.map((e) => e.id).toList());

    result.fold((failure) {
      // On failure, keep selected products and emit error
      emit(ProductsLoadFailure(failure.message));
    }, (disableResponse) {
      // On success, clear selected products and emit success
      selectedProducts.clear();
      emit(ProductsLoadSuccess(
        products,
        selectedProducts,
      ));
    });
  }

  void addSelectedProduct(int id) {
    final product = products.firstWhere((e) => e.id == id);
    selectedProducts.add(product);
  }

  void removeSelectedProduct(int id) {
    selectedProducts.removeWhere((e) => e.id == id);
  }

  void toggleProductSelection(int id) {
    final isSelected = selectedProducts.any((e) => e.id == id);

    if (isSelected) {
      removeSelectedProduct(id);
    } else {
      addSelectedProduct(id);
    }

    emit(ProductsLoadSuccess(products, selectedProducts));
  }

  Future<void> getStoreProductsWitheFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    int? categoryId,
  }) async {
    // if (pageNumber == 1) {
    //   products.clear();
    // }
    // emit(ProductsLoadInProgress());
    // currentStoreProductsFilter = storeProductsFilter;
    // currentMainCategoryId = categoryId;

    // var params = ProductsParams(storeProductsFilter, pageNumber, pageSize);
    // var result = await getProductsUseCase.execute(params);

    // result.fold(
    //   (failure) {
    //     if (pageNumber == 1) {
    //       emit(ProductsLoadFailure(failure.message));
    //     } else {
    //       emit(ProductsLoadSuccess(
    //         products,
    //         List<bool>.filled(products.length, false),
    //         [],
    //       ));
    //     }
    //   },
    //   (fetchedProducts) {
    //     if (pageNumber == 1) {
    //       products = fetchedProducts;
    //     } else {
    //       products.addAll(fetchedProducts);
    //     }
    //     emit(ProductsLoadSuccess(
    //       products,
    //       List<bool>.filled(products.length, false),
    //       [],
    //     ));
    //   },
    // );
  }

  Future<void> getProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());

    if (pageNumber == 1) {
      products.clear();
    }

    var params = ProductsParams(pageNumber, pageSize, 0);
    var result = await getProductsUseCase.execute(params);

    result.fold((failure) {
      if (pageNumber == 1) {
        emit(ProductsLoadFailure(failure.message));
      } else {
        emit(ProductsLoadSuccess(
          products,
          [],
        ));
      }
    }, (fetchedProducts) {
      if (pageNumber == 1) {
        products = fetchedProducts;
      } else {
        products.addAll(fetchedProducts);
      }

      emit(ProductsLoadSuccess(
        products,
        [],
      ));
    });
  }
}

//     var result = await getProductsUseCase.execute(params);

//     result.fold((failure) {
//       if (pageNumber == 1) {
//         emit(ProductsLoadFailure(failure.message));
//       } else {
//         emit(ProductsLoadSuccess(
//           products,
//           [],
//         ));
//       }
//     }, (fetchedProducts) {
//       if (pageNumber == 1) {
//         products = fetchedProducts;
//       } else {
//         products.addAll(fetchedProducts);
//       }

//       emit(ProductsLoadSuccess(
//         products,
//         [],
//       ));
//     });
//   }
// }
