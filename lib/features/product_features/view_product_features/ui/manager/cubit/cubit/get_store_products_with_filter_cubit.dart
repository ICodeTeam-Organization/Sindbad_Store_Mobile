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
      emit(GetStoreProductsWithFilterSuccess(products));
    });
  }
  //
}
