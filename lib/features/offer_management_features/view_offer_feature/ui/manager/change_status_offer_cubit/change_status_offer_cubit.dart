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

      result.fold((failure) => emit(ChangeStatusOfferFailure(failure.message)),
          (changeStatusOffer) {
        if (changeStatusOffer.isSuccess == true) {
          emit(ChangeStatusOfferSuccess("تم تعديل العرض بنجاح"));
        } else {
          emit(ChangeStatusOfferFailure("فشلت عملية تحويل حالة العرض"));
        }
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
