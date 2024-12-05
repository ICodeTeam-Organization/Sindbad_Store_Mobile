import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/add_offer_model/add_offer_dto.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/usecases/add_offer_use_case.dart';

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
      if (add.serverMessage == "The addOfferHeadDto field is required.") {
        emit(AddOfferFailure('احد الحقول المطلوبة فارغة'));
        // } else if (add.serverMessage == "Store ID not found in token") {
        //   emit(AddOfferFailure("Store ID not found in token..."));
      } else {
        emit(AddOfferSuccess("تم أضافة العرض بنجاح"));
      }
    });
  }
}
