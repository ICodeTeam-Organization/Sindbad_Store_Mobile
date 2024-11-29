import 'package:bloc/bloc.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_details_cubit/offer_details_state.dart';

class OfferDetailsCubit extends Cubit<OfferDetailsState> {
  final GetOfferDetailsUseCase getOfferDetailsUseCase;
  OfferDetailsCubit(this.getOfferDetailsUseCase)
      : super(
          OfferDetailsInitial(),
        );
  Future<void> getOfferDetails({
    int pageSize = 10,
    int pageNumber = 1,
    required int offerHeadId,
  }) async {
    emit(
      OfferDetailsLoading(),
    );
    var result = await getOfferDetailsUseCase.execute(OfferDetailsParams(
      pageNumber,
      pageSize,
      offerHeadId,
    ));

    result.fold((failuer) {
      emit(
        OfferDetailsFailuer(errMessage: failuer.message),
      );
    }, (offerDetails) {
      emit(
        OfferDetailsSuccess(offerDetails: offerDetails),
      );
    });
  }
}
