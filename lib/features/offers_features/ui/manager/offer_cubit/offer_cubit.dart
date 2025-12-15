import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_params.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_usecase_1.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final GetOffersUseCase getOfferUseCase;
  final AddOfferUseCase addOfferUseCase;
  OfferCubit(this.getOfferUseCase, this.addOfferUseCase)
      : super(OfferInitial());
  Future<void> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    // List<AddOfferDto>? listProduct,
    List<Map<String, dynamic>>? listProduct,
  ) async {
    emit(OfferLoadInProgress());

    var params = AddOfferParams(
      offerTitle,
      startOffer,
      endOffer,
      countProducts,
      typeName,
      listProduct,
    );
    final result = await addOfferUseCase.execute(params);

    result.fold(
        // left
        (failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
        // right
        (add) {
      // if (add.serverMessage == "The addOfferHeadDto field is required.") {
      //   emit(AddOfferFailure('احد الحقول المطلوبة فارغة'));
      // } else {
      //   emit(AddOfferSuccess("تم أضافة العرض بنجاح"));
      // }
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
