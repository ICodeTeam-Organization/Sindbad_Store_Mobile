// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';

// import '../../../domain/entities/disable_products_entity.dart';
// part 'disable_products_by_ids_state.dart';

// class DisableProductsByIdsCubit extends Cubit<DisableProductsByIdsState> {
//   DisableProductsByIdsCubit(this.disableProductsByIdsUseCase)
//       : super(DisableProductsByIdsInitial());

//   final DisableProductsUseCase disableProductsByIdsUseCase;

//   void disableProductsByIds({required List<int> ids}) async {
//     emit(DisableProductsByIdsLoading());
//     DisableProductsParams params = DisableProductsParams(ids: ids);

//     var result = await disableProductsByIdsUseCase.execute(params);
//     result.fold(
//         // left
//         (failure) {
//       emit(DisableProductsByIdsFailure(errMessage: failure.message));
//     },
//         // right
//         (responseMessage) {
//       emit(DisableProductsByIdsSuccess(message: responseMessage));
//     });
//   }
// }
