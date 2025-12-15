// import 'package:bloc/bloc.dart';
// import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_details_use_case.dart';
// import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_details_cubit/offer_details_state.dart';

// class OfferDetailsCubit extends Cubit<OfferDetailsState> {
//   final GetOfferDetailsUseCase getOfferDetailsUseCase;
//   OfferDetailsCubit(this.getOfferDetailsUseCase) : super(OfferDetailsInitial());
//   Future<void> getOfferDetails(
//     int pageSize,
//     int pageNumber,
//     int offerHeadId,
//   ) async {
//     emit(OfferDetailsLoading());
//     var params = OfferDetailsParams(pageSize, pageNumber, offerHeadId);
//     var result = await getOfferDetailsUseCase.execute(params);

//     result.fold((failuer) {
//       emit(OfferDetailsFailuer(errMessage: failuer.message));
//     }, (offerDetails) {
//       emit(OfferDetailsSuccess(offerDetails: offerDetails));
//     });
//   }
// }
