import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_products_parames.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_products_usecase.dart';

part 'products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.getProductsUseCase) : super(ProductsInitial());
  final GetProductsUseCase getProductsUseCase;

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
        isLoadingMore: false,
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
      emit(ProductsLoadInProgress());
    } else if (state is ProductsLoadSuccess) {
      // show loading indicator while paginating
      final current = state as ProductsLoadSuccess;
      emit(ProductsLoadSuccess(
        current.products,
        current.checkedStates,
        current.productsSelected,
        isLoadingMore: true,
      ));
    }
    currentStoreProductsFilter = storeProductsFilter;
    currentMainCategoryId = categoryId;

    var params = ProductsParams(storeProductsFilter, pageNumber, pageSize);
    var result = await getProductsUseCase.execute(params);

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(ProductsLoadFailure(failure.message));
        } else if (state is ProductsLoadSuccess) {
          final current = state as ProductsLoadSuccess;
          emit(ProductsLoadSuccess(
            current.products,
            current.checkedStates,
            current.productsSelected,
            isLoadingMore: false,
          ));
        }
      },
      (fetchedProducts) {
        if (pageNumber == 1) {
          final List<bool> checkedStates =
              List<bool>.filled(fetchedProducts.length, false);
          emit(ProductsLoadSuccess(fetchedProducts, checkedStates, []));
        } else if (state is ProductsLoadSuccess) {
          final current = state as ProductsLoadSuccess;
          final List<ProductEntity> allProducts = List.from(current.products)
            ..addAll(fetchedProducts);
          final List<bool> newCheckedStates = List.from(current.checkedStates)
            ..addAll(List<bool>.filled(fetchedProducts.length, false));
          emit(ProductsLoadSuccess(
            allProducts,
            newCheckedStates,
            current.productsSelected,
            isLoadingMore: false,
          ));
        }
      },
    );
  }

  Future<void> getProducts(
    int pageNumber,
    int pageSize,
    int? categoryId,
  ) async {
    emit(ProductsLoadInProgress());
    var params = ProductsParams(pageNumber, pageSize, 0);
    var result = await getProductsUseCase.execute(params);

    // final List<ProductEntity> dummyProducts = List.generate(
    //   10,
    //   (index) => ProductEntity(
    //     productId: index + 1,
    //     productName: 'Product ${index + 1}',
    //     productNumber: 'P-${1000 + index}',
    //     productPrice: 100 + (index * 10),
    //     productImageUrl: 'https://via.placeholder.com/150',
    //   ),
    // );

    // final List<bool> checkedStates =
    //     List<bool>.filled(dummyProducts.length, false);
    result.fold((failure) {
      // if (pageNumber == 1) {
      //   emit(ProductsLoadFailure(failure.message));
      // } else if (state is ProductsLoadSuccess) {
      //   final current = state as ProductsLoadSuccess;
      emit(ProductsLoadFailure(failure.message));
      //  }
    }, (fetchedProducts) {
      emit(ProductsLoadSuccess(
        fetchedProducts,
        List<bool>.filled(fetchedProducts.length, false),
        [],
        isLoadingMore: false,
      ));
    });
  }
}
