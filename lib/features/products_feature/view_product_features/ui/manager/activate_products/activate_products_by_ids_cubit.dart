// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../domain/use_cases/activate_products_by_ids_use_case.dart';
// part 'activate_products_by_ids_state.dart';

// class ActivateProductsByIdsCubit extends Cubit<ActivateProductsByIdsState> {
//   ActivateProductsByIdsCubit(this.activateProductsByIdsUseCase)
//       : super(ActivateProductsByIdsInitial());

//   final ActivateProductsUseCase activateProductsByIdsUseCase;

//   void activateProductsByIds(List<int> ids) async {
//     emit(ActivateProductsByIdsLoading());
//     ActivateProductsParams params = ActivateProductsParams(ids);

//     var result = await activateProductsByIdsUseCase.execute(params);
//     result.fold(
//         // left
//         (failure) {
//       emit(ActivateProductsByIdsFailure(errMessage: failure.message));
//     },
//         // right
//         (responseMessage) {
//       emit(ActivateProductsByIdsSuccess(message: responseMessage));
//     });
//   }
// }
