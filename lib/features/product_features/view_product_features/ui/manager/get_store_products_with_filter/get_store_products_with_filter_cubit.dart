import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/entities/delete_entity_product.dart';
import '../../../domain/entities/product_entity.dart';
// import '../../../domain/usecases/delete_product_by_id_use_case.dart';
import '../../../domain/usecases/get_products_by_filter_use_case.dart';

part 'get_store_products_with_filter_state.dart';

class GetStoreProductsWithFilterCubit
    extends Cubit<GetStoreProductsWithFilterState> {
  GetStoreProductsWithFilterCubit(this.getProductsByFilterUseCase)
      : super(GetStoreProductsWithFilterInitial());
  final GetProductsByFilterUseCase getProductsByFilterUseCase;

  List<int> updatedProductsSelected = [];
  // الدالة لتحديث حالة الـ Checkbox
  void updateCheckboxState(int index, bool value, int productId) {
    if (state is GetStoreProductsWithFilterSuccess) {
      final currentState = state as GetStoreProductsWithFilterSuccess;
      // إنشاء قائمة جديدة تحتوي على جميع الحالات القديمة مع تحديث الحالة المطلوبة
      final List<bool> updatedCheckedStates =
          List<bool>.from(currentState.checkedStates);
      // final List<String> updatedProductsSelected =
      updatedProductsSelected = List<int>.from(currentState.productsSelected);
      updatedCheckedStates[index] = value; // تحديث الحالة في الفهرس المحدد
      value
          ? updatedProductsSelected.add(productId)
          : updatedProductsSelected
              .remove(productId); // تحديث الحالة في  العنصر المختار
      print(updatedProductsSelected);

      // إعادة إصدار الـ state الجديد مع الحالة المحدثة
      emit(GetStoreProductsWithFilterSuccess(currentState.products,
          updatedCheckedStates, updatedProductsSelected));
    }
  }

  // for get products
  Future<void> getStoreProductsWitheFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    int? categoryId,
  }) async {
    emit(GetStoreProductsWithFilterLoading());
    var params = ProductsByFilterParams(
        storeProductsFilter, pageNumper, pageSize, categoryId);

    var result = await getProductsByFilterUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(GetStoreProductsWithFilterFailure(failure.message));
    },
        // right
        (products) {
      // تهيئة جميع القوائم
      final List<bool> checkedStates =
          List<bool>.filled(products.length, false);
      final List<int> productsSelected = [];
      updatedProductsSelected = [];
      emit(GetStoreProductsWithFilterSuccess(
          products, checkedStates, productsSelected));
    });
  }
}
