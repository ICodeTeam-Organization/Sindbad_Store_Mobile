import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_params.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_usecase_1.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';

class OfferCubit extends Cubit<OfferState> {
  final GetOffersUseCase getOfferUseCase;
  final AddOfferUseCase addOfferUseCase;
  OfferCubit(this.getOfferUseCase, this.addOfferUseCase)
      : super(OfferInitial());
  Future<void> addOffer({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int numberOfOrders,
    required int offerHeadType,
    required List<Map<String, dynamic>> offerHeadOffers,
  }) async {
    emit(OfferLoadInProgress());

    var params = AddOfferParams(
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      numberOfOrders: numberOfOrders,
      offerHeadType: offerHeadType,
      offerHeadOffers: offerHeadOffers,
    );
    final result = await addOfferUseCase.execute(params);

    result.fold(
        // left
        (failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
        // right
        (add) {
      emit(OfferLoadSuccess([]));
    });
  }

  Future<void> getOffer(
    int pageSize,
    int pageNumber,
  ) async {
    emit(OfferLoadInProgress());
    var params = OfferParams(pageSize, pageNumber);
    var result = await getOfferUseCase.execute(params);

    result.fold((failuer) {
      emit(OfferLoadFailuer(errMessage: failuer.message));
    }, (offer) {
      emit(OfferLoadSuccess(offer));
    });
  }
}
