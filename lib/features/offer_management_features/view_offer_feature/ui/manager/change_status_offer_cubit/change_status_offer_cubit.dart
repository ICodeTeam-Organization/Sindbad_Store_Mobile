import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/change_status_offer_use_case.dart';

part 'change_status_offer_state.dart';

class ChangeStatusOfferCubit extends Cubit<ChangeStatusOfferState> {
  final ChangeStatusOfferUseCase deleteOfferUseCase;
  ChangeStatusOfferCubit(this.deleteOfferUseCase)
      : super(ChangeStatusOfferInitial());

  Future<void> changeStatusOffer(int offerHeadId) async {
    emit(ChangeStatusOfferLoading());

    try {
      var params = ChangeStatusOfferParams(offerHeadId);
      final result = await deleteOfferUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(ChangeStatusOfferFailure(failure.message)),
          // right
          (changeStatusOffer) {
        if (changeStatusOffer.isSuccess == true) {
          emit(ChangeStatusOfferSuccess("تم تعديل العرض بنجاح"));
        } else {
          emit(ChangeStatusOfferFailure("فشلت عملية تحويل حالة العرض"));
        }
        // if (delete.serverMessage ==
        //     "OfferHead not found or you do not have permission to delete it") {
        //   emit(ChangeStatusOfferFailure("منتج غير موجود"));
        //   //
        // } else if (delete.serverMessage == "Store ID not found in token") {
        //   emit(ChangeStatusOfferFailure("Store ID not found in token..."));
        // } else {
        //   emit(ChangeStatusOfferSuccess("تم حذف العرض بنجاح"));
        // }
      });
    } catch (e) {
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(ChangeStatusOfferFailure(failure.message));
      } else {
        emit(ChangeStatusOfferFailure(e.toString()));
      }
    }
  }
}
