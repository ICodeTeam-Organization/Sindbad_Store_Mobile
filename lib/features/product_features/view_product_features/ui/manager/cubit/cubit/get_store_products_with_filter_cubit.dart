import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/usecases/get_products_by_filter_use_case.dart';

part 'get_store_products_with_filter_state.dart';

class GetStoreProductsWithFilterCubit
    extends Cubit<GetStoreProductsWithFilterState> {
  GetStoreProductsWithFilterCubit(this.getProductsByFilterUseCase)
      : super(GetStoreProductsWithFilterInitial());
  final GetProductsByFilterUseCase getProductsByFilterUseCase;

  // الدالة لتحديث حالة الـ Checkbox
  void updateCheckboxState(int index, bool value) {
    if (state is GetStoreProductsWithFilterSuccess) {
      final currentState = state as GetStoreProductsWithFilterSuccess;
      // إنشاء قائمة جديدة تحتوي على جميع الحالات القديمة مع تحديث الحالة المطلوبة
      final updatedCheckedStates = List<bool>.from(currentState.checkedStates);
      updatedCheckedStates[index] = value; // تحديث الحالة في الفهرس المحدد

      // إعادة إصدار الـ state الجديد مع الحالة المحدثة
      emit(GetStoreProductsWithFilterSuccess(
        currentState.products,
        updatedCheckedStates,
      ));
    }
  }

  // for get products
  Future<void> getStoreProductsWitheFilter(
      int storeProductsFilter, int pageNumper, int pageSize) async {
    emit(GetStoreProductsWithFilterLoading());
    var params =
        ProductsByFilterParams(storeProductsFilter, pageNumper, pageSize);

    var result = await getProductsByFilterUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(GetStoreProductsWithFilterFailure(failure.message));
    },
        // right
        (products) {
      // تهيئة حالة checkedStates بناءً على عدد المنتجات
      final checkedStates = List<bool>.filled(products.length, false);
      emit(GetStoreProductsWithFilterSuccess(products, checkedStates));
    });
  }
}
