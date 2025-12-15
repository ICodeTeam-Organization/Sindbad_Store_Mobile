// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';
// import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_usecase_1.dart';

// part 'add_offer_state.dart';

// class AddOfferCubit extends Cubit<AddOfferState> {
//   final AddOfferUseCase addOfferUseCase;
//   AddOfferCubit(this.addOfferUseCase) : super(AddOfferInitial());

//   Future<void> addOffer({
//     required String name,
//     required String description,
//     required DateTime startDate,
//     required DateTime endDate,
//     required bool isActive,
//     required int numberOfOrders,
//     required int offerHeadType,
//     required List<Map<String, dynamic>> offerHeadOffers,
//   }) async {
//     emit(AddOfferLoading());

//     var params = AddOfferParams(
//       name: name,
//       description: description,
//       startDate: startDate,
//       endDate: endDate,
//       isActive: isActive,
//       numberOfOrders: numberOfOrders,
//       offerHeadType: offerHeadType,
//       offerHeadOffers: offerHeadOffers,
//     );
//     final result = await addOfferUseCase.execute(params);

//     result.fold(
//         // left
//         (failure) => emit(AddOfferFailure(failure.message)),
//         // right
//         (add) {
//       emit(AddOfferSuccess("تم أضافة العرض بنجاح"));
//     });
//   }
// }
