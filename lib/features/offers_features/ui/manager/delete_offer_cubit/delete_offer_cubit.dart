// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:meta/meta.dart';
// import 'package:sindbad_management_app/core/errors/failure.dart';
// import 'package:sindbad_management_app/features/offers_features/domain/usecases/delete_offer_use_case.dart';

// part 'delete_offer_state.dart';

// class DeleteOfferCubit extends Cubit<DeleteOfferState> {
//   final DeleteOfferUseCase deleteOfferUseCase;
//   DeleteOfferCubit(this.deleteOfferUseCase) : super(DeleteOfferInitial());

//   Future<void> deleteOffer(int offerHeadId) async {
//     emit(DeleteOfferLoading());

//     try {
//       var params = DeleteOfferParams(offerHeadId);
//       final result = await deleteOfferUseCase.execute(params);

//       result.fold(
//           // left
//           (failure) => emit(DeleteOfferFailure(failure.message)),
//           // right
//           (delete) {
//         if (delete.serverMessage ==
//             "OfferHead not found or you do not have permission to delete it") {
//           emit(DeleteOfferFailure("منتج غير موجود"));
//           //
//         } else if (delete.serverMessage == "Store ID not found in token") {
//           emit(DeleteOfferFailure("Store ID not found in token..."));
//         } else {
//           emit(DeleteOfferSuccess("تم حذف العرض بنجاح"));
//         }
//       });
//     } catch (e) {
//       if (e is DioException) {
//         ServerFailure failure = ServerFailure.fromDioError(e);
//         emit(DeleteOfferFailure(failure.message));
//       } else {
//         emit(DeleteOfferFailure(e.toString()));
//       }
//     }
//   }
// }

// extension on Object {
//   Null get serverMessage => null;
// }
