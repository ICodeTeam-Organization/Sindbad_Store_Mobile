import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../../../domain/usecases/get_product_details_to_store_use_case.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsToStoreUseCase getProductDetailsToStoreUseCase;
  ProductDetailsCubit(this.getProductDetailsToStoreUseCase)
      : super(ProductDetailsInitial());

  void getProductDetails({required int productId}) async {
    emit(ProductDetailsLoading());
    GetProductDetailsToStoreParams params =
        GetProductDetailsToStoreParams(productId: productId);
    Either<Failure, ProductDetailsEntity> result =
        await getProductDetailsToStoreUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(ProductDetailsFailure(
          errMessage: failure.message)); // ======== emit ==========
    },
        // right
        (brands) {
      emit(ProductDetailsSuccess(
          productDetailsEntity: brands)); // ======== emit ==========
    });
  }
}
