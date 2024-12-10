import 'package:bloc/bloc.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/get_offer_products_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_state.dart';

class OfferProductsCubit extends Cubit<OfferProductsState> {
  final GetOfferProductsUseCase getOfferProductsUseCase;
  OfferProductsCubit(this.getOfferProductsUseCase)
      : super(OfferProductsInitial());
  Future<void> getOfferProducts(int pageNumber) async {
    if (pageNumber == 1) {
      emit(OfferProductsLoading());
    } else {
      emit(OfferProductsPaginationLoading());
    }
    var params = OfferProductsParams(pageNumber);
    var result = await getOfferProductsUseCase.execute(params);

    result.fold((failuer) {
      if (pageNumber == 1) {
        emit(OfferProductsFailuer(failuer.message));
      } else {
        emit(OfferProductsPaginationFailure(failuer.message));
      }
    }, (offerProducts) {
      emit(OfferProductsSuccess(offerProducts: offerProducts));
    });
  }
}
