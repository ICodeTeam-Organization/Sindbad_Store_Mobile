import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/offers_feature/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_feature/view_offer_feature/domain/usecases/get_offer_use_case.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final GetOfferUseCase getOfferUseCase;
  OfferCubit(this.getOfferUseCase) : super(OfferInitial());

  Future<void> getOffer(
    int pageSize,
    int pageNumber,
  ) async {
    emit(OfferLoading());
    var params = OfferParams(pageSize, pageNumber);
    var result = await getOfferUseCase.execute(params);

    result.fold((failuer) {
      emit(OfferFailuer(errMessage: failuer.message));
    }, (offer) {
      emit(OfferSuccess(offer: offer));
    });
  }
}
