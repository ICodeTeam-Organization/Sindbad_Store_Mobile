import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/get_offer_data_use_case.dart';

part 'offer_data_state.dart';

class OfferDataCubit extends Cubit<OfferDataState> {
  final GetOfferDataUseCase getOfferDataUseCase;
  OfferDataCubit(this.getOfferDataUseCase) : super(OfferDataInitial());
  Future<void> getOfferData(int offerHeadId) async {
    emit(OfferDataLoading());
    var params = OfferDataParams(offerHeadId);
    var result = await getOfferDataUseCase.execute(params);

    result.fold((failuer) {
      emit(OfferDataFailuer(errMessage: failuer.message));
    }, (offerData) {
      emit(OfferDataSuccess(offerData: offerData));
    });
  }
}
