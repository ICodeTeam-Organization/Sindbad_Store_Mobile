import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_usecase_1.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  final AddOfferUseCase addOfferUseCase;
  AddOfferCubit(this.addOfferUseCase) : super(AddOfferInitial());

  Future<void> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    // List<AddOfferDto>? listProduct,
    List<Map<String, dynamic>>? listProduct,
  ) async {
    emit(AddOfferLoading());

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
        (failure) => emit(AddOfferFailure(failure.message)),
        // right
        (add) {
      // if (add.serverMessage == "The addOfferHeadDto field is required.") {
      //   emit(AddOfferFailure('احد الحقول المطلوبة فارغة'));
      // } else {
      //   emit(AddOfferSuccess("تم أضافة العرض بنجاح"));
      // }
    });
  }
}
