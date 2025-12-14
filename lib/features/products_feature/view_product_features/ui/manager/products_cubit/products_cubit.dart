import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/add_products_parames.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/edit_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_products_parames.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/activate_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/add_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/delete_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_products_usecase.dart';

part 'products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(
      this.getProductsUseCase,
      this._disableProductsUseCase,
      this._activateProductsUseCase,
      this._deleteProductUseCase,
      this._addProductUseCase,
      this._updateProductUseCase)
      : super(ProductsInitial());
  final GetProductsUseCase getProductsUseCase;
  final DisableProductsUseCase _disableProductsUseCase;
  final ActivateProductsUseCase _activateProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final AddProductUseCase _addProductUseCase;
  final EditProductUseCase _updateProductUseCase;

  // Separate lists for each tab
  List<ProductEntity> allProducts = [];
  List<ProductEntity> offeredProducts = [];
  List<ProductEntity> stoppedProducts = [];

  // Legacy - kept for backward compatibility
  List<ProductEntity> products = [];
  List<ProductEntity> selectedProducts = [];

  // Separate selected items for each tab
  List<ProductEntity> selectedAllProducts = [];
  List<ProductEntity> selectedOfferedProducts = [];
  List<ProductEntity> selectedStoppedProducts = [];

  // used for refreshing the list
  int? currentStoreProductsFilter;
  int? currentMainCategoryId;

  Future<void> stopSelectedProducts() async {
    var result = await _disableProductsUseCase
        .execute(selectedProducts.map((e) => e.id).toList());

    result.fold((failure) {
      emit(ProductsLoadFailure(failure.message));
    }, (disableResponse) {
      selectedProducts.clear();
      emit(ProductsLoadSuccess(
        products,
        selectedProducts,
      ));
    });
  }

  Future<void> addProduct(
      String name,
      double price,
      String number,
      double oldPrice,
      String description,
      File mainImageFile,
      List<File> images,
      int mainCategoryId,
      int? subCategoryId,
      int? brandId) async {
    emit(ProductsLoadInProgress());

    var result = await _addProductUseCase.execute(
      AddProductParams(
        name: name,
        price: price,
        number: number,
        description: description,
        oldPrice: oldPrice,
        mainImageFile: mainImageFile,
        mainCategoryId: mainCategoryId,
        subCategoryIds: subCategoryId != null ? [subCategoryId] : [],
        tags: [],
        storeId: null,
        offerId: null,
        brandId: brandId,
        images: images,
        newAttributes: [],
        shortDescription: '',
      ),
    );
// images:
//       subCategoryIds: [selectedSubCategoryId!],
//       newAttributes: [
//         for (int i = 0; i < keys.length; i++)
//           {"attributeName": keys[i].text, "attributeValue": values[i].text}
//       ],
    result.fold((failure) {
      emit(ProductsLoadFailure(failure.message));
    }, (addResponse) {
      emit(ProductsLoadSuccess(
        products,
        selectedProducts,
      ));
    });
  }

  Future<void> deleteProduct(int productId) async {
    emit(ProductsLoadInProgress());

    var result = await _deleteProductUseCase.execute(productId);

    result.fold((failure) {
      emit(ProductsLoadFailure(failure.message));
    }, (deleteResponse) {
      // Remove the product from all lists
      allProducts.removeWhere((e) => e.id == productId);
      products.removeWhere((e) => e.id == productId);
      offeredProducts.removeWhere((e) => e.id == productId);
      stoppedProducts.removeWhere((e) => e.id == productId);

      emit(ProductsLoadSuccess(products, selectedProducts));
    });
  }

  Future<void> activateSelectedProducts() async {
    var result = await _activateProductsUseCase
        .execute(selectedStoppedProducts.map((e) => e.id).toList());

    result.fold((failure) {
      emit(ProductsLoadFailure(failure.message));
    }, (disableResponse) {
      selectedStoppedProducts.clear();
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

  // Legacy toggle method (for backward compatibility)
  void toggleProductSelection(int id) {
    toggleAllProductSelection(id);
  }

  // =================== TOGGLE METHODS FOR EACH TAB ===================

  void toggleAllProductSelection(int id) {
    final isSelected = selectedAllProducts.any((e) => e.id == id);

    if (isSelected) {
      selectedAllProducts.removeWhere((e) => e.id == id);
    } else {
      final product = allProducts.firstWhere((e) => e.id == id);
      selectedAllProducts.add(product);
    }

    // Update legacy lists for backward compatibility
    selectedProducts = selectedAllProducts;
    emit(ProductsLoadSuccess(allProducts, selectedAllProducts));
  }

  void toggleOfferedProductSelection(int id) {
    final isSelected = selectedOfferedProducts.any((e) => e.id == id);

    if (isSelected) {
      selectedOfferedProducts.removeWhere((e) => e.id == id);
    } else {
      final product = offeredProducts.firstWhere((e) => e.id == id);
      selectedOfferedProducts.add(product);
    }

    emit(ProductsLoadSuccess(offeredProducts, selectedOfferedProducts));
  }

  void toggleStoppedProductSelection(int id) {
    final isSelected = selectedStoppedProducts.any((e) => e.id == id);

    if (isSelected) {
      selectedStoppedProducts.removeWhere((e) => e.id == id);
    } else {
      final product = stoppedProducts.firstWhere((e) => e.id == id);
      selectedStoppedProducts.add(product);
    }

    emit(ProductsLoadSuccess(stoppedProducts, selectedStoppedProducts));
  }

  Future<void> getStoreProductsWitheFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    int? categoryId,
  }) async {
    if (pageNumber == 1) {
      products.clear();
    }
    emit(ProductsLoadInProgress());
    currentStoreProductsFilter = storeProductsFilter;
    currentMainCategoryId = categoryId;

    var params = ProductsParams(pageNumber, pageSize, categoryId);
    var result = await getProductsUseCase.execute(params);

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(ProductsLoadFailure(failure.message));
        } else {
          emit(ProductsLoadSuccess(
            products,
            selectedProducts,
          ));
        }
      },
      (fetchedProducts) {
        if (pageNumber == 1) {
          products = fetchedProducts;
        } else {
          products.addAll(fetchedProducts);
        }
        emit(ProductsLoadSuccess(
          products,
          selectedProducts,
        ));
      },
    );
  }

  // =================== ALL PRODUCTS TAB ===================
  Future<void> getAllProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());

    if (pageNumber == 1) {
      allProducts.clear();
    }

    var params = ProductsParams(pageNumber, pageSize, categoryId);
    var result = await getProductsUseCase.execute(params);

    result.fold((failure) {
      if (pageNumber == 1) {
        emit(ProductsLoadFailure(failure.message));
      } else {
        emit(ProductsLoadSuccess(allProducts, selectedAllProducts));
      }
    }, (fetchedProducts) {
      if (pageNumber == 1) {
        allProducts = fetchedProducts;
      } else {
        allProducts.addAll(fetchedProducts);
      }
      // Also update legacy products list for backward compatibility
      products = allProducts;
      selectedProducts = selectedAllProducts;
      emit(ProductsLoadSuccess(allProducts, selectedAllProducts));
    });
  }

  // =================== OFFERED PRODUCTS TAB ===================
  Future<void> getOfferedProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());

    if (pageNumber == 1) {
      offeredProducts.clear();
    }

    // TODO: Replace with offered products endpoint when available
    var params = ProductsParams(pageNumber, pageSize, categoryId);
    var result = await getProductsUseCase.execute(params);

    result.fold((failure) {
      if (pageNumber == 1) {
        emit(ProductsLoadFailure(failure.message));
      } else {
        emit(ProductsLoadSuccess(offeredProducts, selectedOfferedProducts));
      }
    }, (fetchedProducts) {
      if (pageNumber == 1) {
        offeredProducts = fetchedProducts;
      } else {
        offeredProducts.addAll(fetchedProducts);
      }
      emit(ProductsLoadSuccess(offeredProducts, selectedOfferedProducts));
    });
  }

  // =================== STOPPED PRODUCTS TAB ===================
  Future<void> getStoppedProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());

    if (pageNumber == 1) {
      stoppedProducts.clear();
    }

    // TODO: Replace with stopped products endpoint when available
    var params = ProductsParams(pageNumber, pageSize, categoryId);
    var result = await getProductsUseCase.execute(params);

    result.fold((failure) {
      if (pageNumber == 1) {
        emit(ProductsLoadFailure(failure.message));
      } else {
        emit(ProductsLoadSuccess(stoppedProducts, selectedStoppedProducts));
      }
    }, (fetchedProducts) {
      if (pageNumber == 1) {
        stoppedProducts = fetchedProducts;
      } else {
        stoppedProducts.addAll(fetchedProducts);
      }
      emit(ProductsLoadSuccess(stoppedProducts, selectedStoppedProducts));
    });
  }

  // Legacy method - kept for backward compatibility
  Future<void> getProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    // Delegate to getAllProducts
    await getAllProducts(pageNumber, pageSize, categoryId);
  }

  Future<void> updateProduct() async {
    // Delegate to getAllProducts
  }
}
