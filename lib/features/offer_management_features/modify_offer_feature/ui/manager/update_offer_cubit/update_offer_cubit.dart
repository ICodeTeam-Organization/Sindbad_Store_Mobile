import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/update_offer_use_case.dart';

part 'update_offer_state.dart';

class UpdateOfferCubit extends Cubit<UpdateOfferState> {
  final UpdateOfferUseCase updateOfferUseCase;
  UpdateOfferCubit(this.updateOfferUseCase) : super(UpdateOfferInitial());

  Future<void> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    // List<UpdateOfferDto>? listProduct,
    List<OfferHeadOffer>? listProduct,
  ) async {
    emit(UpdateOfferLoading());

    var params = UpdateOfferParams(
      offerTitle,
      startOffer,
      endOffer,
      countProducts,
      typeName,
      listProduct,
    );
    final result = await updateOfferUseCase.execute(params);

    result.fold(
        // left
        (failure) => emit(UpdateOfferFailure(failure.message)),
        // right
        (update) {
      if (update.serverMessage == "The addOfferHeadDto field is required.") {
        emit(UpdateOfferFailure('احد الحقول المطلوبة فارغة'));
      } else {
        emit(UpdateOfferSuccess("تم تحديث العرض بنجاح"));
      }
    });
  }
}
