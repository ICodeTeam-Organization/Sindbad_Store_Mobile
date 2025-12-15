import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_params.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_usecase_1.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/change_status_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/delete_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_products_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/update_offer_use_case.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  final GetOffersUseCase getOfferUseCase;
  final AddOfferUseCase addOfferUseCase;
  final DeleteOfferUseCase deleteOfferUseCase;
  final ChangeStatusOfferUseCase changeStatusOfferUseCase;
  final GetOfferDetailsUseCase getOfferDetailsUseCase;
  final GetOfferProductsUseCase getOfferProductsUseCase;
  final UpdateOfferUseCase updateOfferUseCase;

  // Store offers list in the cubit
  List<OfferEntity> offers = [];

  OfferCubit(
      this.getOfferUseCase,
      this.addOfferUseCase,
      this.deleteOfferUseCase,
      this.changeStatusOfferUseCase,
      this.getOfferDetailsUseCase,
      this.getOfferProductsUseCase,
      this.updateOfferUseCase)
      : super(OfferInitial());

  Future<void> changeStatusOffer(int offerHeadId) async {
    emit(OfferLoadInProgress());

    try {
      var params = ChangeStatusOfferParams(offerHeadId);
      final result = await changeStatusOfferUseCase.execute(params);

      result.fold(
          (failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
          (changeStatusOffer) {
        // Toggle the status of the offer in the local list
        final index = offers.indexWhere((o) => o.offerId == offerHeadId);
        if (index != -1) {
          offers[index] = OfferEntity(
            offerId: offers[index].offerId,
            offerTitle: offers[index].offerTitle,
            typeName: offers[index].typeName,
            isActive: !offers[index].isActive,
            startOffer: offers[index].startOffer,
            endOffer: offers[index].endOffer,
            countProducts: offers[index].countProducts,
            numberToBuy: offers[index].numberToBuy,
            numberToGet: offers[index].numberToGet,
            discountRate: offers[index].discountRate,
          );
        }
        emit(OfferLoadSuccess());
      });
    } catch (e) {
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(OfferLoadFailuer(errMessage: failure.message));
      } else {
        emit(OfferLoadFailuer(errMessage: e.toString()));
      }
    }
  }

  Future<void> getOfferProducts(int pageSize, int pageNumber) async {
    emit(OfferLoadInProgress());
    var params = OfferProductsParams(pageSize, pageNumber);
    var result = await getOfferProductsUseCase.execute(params);

    result.fold((failuer) {
      emit(OfferLoadFailuer(errMessage: failuer.message));
    }, (offerProducts) {
      emit(OfferLoadSuccess());
    });
  }

  Future<void> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  ) async {
    emit(OfferLoadInProgress());

    var params = UpdateOfferParams(
      offerTitle,
      startOffer,
      endOffer,
      countProducts,
      typeName,
      listProduct,
      offerHeadId,
    );
    final result = await updateOfferUseCase.execute(params);

    result.fold(
        // left
        (failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
        // right
        (update) {
      // if (update?.serverMessage == "The addOfferHeadDto field is required.") {
      //   emit(UpdateOfferFailure('احد الحقول المطلوبة فارغة'));
      // } else {
      //   emit(UpdateOfferSuccess("تم تحديث العرض بنجاح"));
      // }
    });
  }

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

    result
        .fold((failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
            (add) {
      // Refresh the offers list after adding
      emit(OfferAddSuccess());
    });
  }

  Future<void> deleteOffer(int offerHeadId) async {
    emit(OfferLoadInProgress());

    try {
      var params = DeleteOfferParams(offerHeadId);
      final result = await deleteOfferUseCase.execute(params);

      result.fold(
          (failure) => emit(OfferLoadFailuer(errMessage: failure.message)),
          (delete) {
        if (delete.serverMessage ==
            "OfferHead not found or you do not have permission to delete it") {
          emit(OfferLoadFailuer(errMessage: "منتج غير موجود"));
        } else if (delete.serverMessage == "Store ID not found in token") {
          emit(OfferLoadFailuer(errMessage: "Store ID not found in token..."));
        } else {
          // Remove the offer from local list
          offers.removeWhere((o) => o.offerId == offerHeadId);
          emit(OfferLoadSuccess());
        }
      });
    } catch (e) {
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(OfferLoadFailuer(errMessage: failure.message));
      } else {
        emit(OfferLoadFailuer(errMessage: e.toString()));
      }
    }
  }

  Future<void> getOfferDetails(
    int pageSize,
    int pageNumber,
    int offerHeadId,
  ) async {
    emit(OfferLoadInProgress());
    var params = OfferDetailsParams(pageSize, pageNumber, offerHeadId);
    var result = await getOfferDetailsUseCase.execute(params);

    result.fold((failuer) {
      emit(OfferLoadFailuer(errMessage: failuer.message));
    }, (offerDetails) {
      emit(OfferLoadSuccess());
    });
  }

  Future<void> getOffers(
    int pageSize,
    int pageNumber,
  ) async {
    emit(OfferLoadInProgress());
    var params = OfferParams(pageSize, pageNumber);
    var result = await getOfferUseCase.execute(params);

    // Mock data for testing
    // offers = [
    //   OfferEntity(
    //     offerId: 1,
    //     offerTitle: 'عرض 1',
    //     typeName: 'عرض',
    //     isActive: true,
    //     startOffer: DateTime.now(),
    //     endOffer: DateTime.now(),
    //     countProducts: 10,
    //     numberToBuy: 2,
    //     numberToGet: 1,
    //     discountRate: 10,
    //   ),
    // ];
    //  emit(OfferLoadSuccess());

    result.fold((failure) {
      emit(OfferLoadFailuer(errMessage: failure.message));
    }, (fetchedOffers) {
      offers = fetchedOffers;
      emit(OfferLoadSuccess());
    });
  }
}
