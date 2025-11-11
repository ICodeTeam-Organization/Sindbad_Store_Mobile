import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/get_products_by_filter_use_case.dart';

part 'get_store_products_with_filter_state.dart';

class GetStoreProductsWithFilterCubit
    extends Cubit<GetStoreProductsWithFilterState> {
  GetStoreProductsWithFilterCubit(this.getProductsByFilterUseCase)
      : super(GetStoreProductsWithFilterInitial());
  final GetProductsByFilterUseCase getProductsByFilterUseCase;

  List<int> updatedProductsSelected = [];

  // used for refreshing the list
  int? currentStoreProductsFilter;
  int? currentMainCategoryId;

  // fun to refresh checkbox state
  void updateCheckboxState(int index, bool value, int productId) {
    if (state is GetStoreProductsWithFilterSuccess) {
      final currentState = state as GetStoreProductsWithFilterSuccess;
      final List<bool> updatedCheckedStates =
          List<bool>.from(currentState.checkedStates);
      updatedProductsSelected = List<int>.from(currentState.productsSelected);
      updatedCheckedStates[index] = value;
      value
          ? updatedProductsSelected.add(productId)
          : updatedProductsSelected.remove(productId);
      debugPrint('==== After checkbox update: $updatedProductsSelected');
      emit(GetStoreProductsWithFilterSuccess(
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
      emit(GetStoreProductsWithFilterLoading());
    } else if (state is GetStoreProductsWithFilterSuccess) {
      // show loading indicator while paginating
      final current = state as GetStoreProductsWithFilterSuccess;
      emit(GetStoreProductsWithFilterSuccess(
        current.products,
        current.checkedStates,
        current.productsSelected,
        isLoadingMore: true,
      ));
    }
    currentStoreProductsFilter = storeProductsFilter;
    currentMainCategoryId = categoryId;

    var params = ProductsByFilterParams(
        storeProductsFilter, pageNumber, pageSize, categoryId);
    var result = await getProductsByFilterUseCase.execute(params);

    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(GetStoreProductsWithFilterFailure(failure.message));
        } else if (state is GetStoreProductsWithFilterSuccess) {
          final current = state as GetStoreProductsWithFilterSuccess;
          emit(GetStoreProductsWithFilterSuccess(
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
          emit(GetStoreProductsWithFilterSuccess(
              fetchedProducts, checkedStates, []));
        } else if (state is GetStoreProductsWithFilterSuccess) {
          final current = state as GetStoreProductsWithFilterSuccess;
          final List<ProductEntity> allProducts = List.from(current.products)
            ..addAll(fetchedProducts);
          final List<bool> newCheckedStates = List.from(current.checkedStates)
            ..addAll(List<bool>.filled(fetchedProducts.length, false));
          emit(GetStoreProductsWithFilterSuccess(
            allProducts,
            newCheckedStates,
            current.productsSelected,
            isLoadingMore: false,
          ));
        }
      },
    );
  }
}
