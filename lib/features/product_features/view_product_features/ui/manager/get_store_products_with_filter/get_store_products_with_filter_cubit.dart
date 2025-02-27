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

  // used for refresh the list
  int? currentStoreProductsFilter;
  int? currentMainCategoryId;

  // fun to refresh list check box state
  void updateCheckboxState(int index, bool value, int productId) {
    if (state is GetStoreProductsWithFilterSuccess) {
      final currentState = state as GetStoreProductsWithFilterSuccess;
      // create new list by old check box state with refresh the new state
      final List<bool> updatedCheckedStates =
          List<bool>.from(currentState.checkedStates);
      // final List<String> updatedProductsSelected =
      updatedProductsSelected = List<int>.from(currentState.productsSelected);
      updatedCheckedStates[index] = value; // refresh the state in item
      value
          ? updatedProductsSelected.add(productId)
          : updatedProductsSelected
              .remove(productId); // refresh the state in item
      debugPrint(
          '==== After checkbox update: $updatedProductsSelected'); // Debugging

      emit(GetStoreProductsWithFilterSuccess(
        currentState.products,
        updatedCheckedStates,
        updatedProductsSelected,
      ));
    }
  }

  // for get products
  Future<void> getStoreProductsWitheFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    int? categoryId,
  }) async {
    if (pageNumber == 1) {
  emit(GetStoreProductsWithFilterLoading());
  }
  else{
    emit(GetStoreProductsWithFilterPaginationLoadging());
  }


    currentStoreProductsFilter = storeProductsFilter;
    currentMainCategoryId = categoryId;

    var params = ProductsByFilterParams(
        storeProductsFilter, pageNumber, pageSize, categoryId);

    var result = await getProductsByFilterUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      if (pageNumber == 1) {
  emit(GetStoreProductsWithFilterFailure(failure.message));
  }
  else{
    emit(GetStoreProductsWithFilterPaginationFaliure(errMessage: failure.message));
}
    },
        // right
        (products) {
      // initialize all lists
      final List<bool> checkedStates =
          List<bool>.filled(products.length, false);
      final List<int> productsSelected = [];
      updatedProductsSelected = [];
      emit(GetStoreProductsWithFilterSuccess(
          products, checkedStates, productsSelected));
    });
  }
}
