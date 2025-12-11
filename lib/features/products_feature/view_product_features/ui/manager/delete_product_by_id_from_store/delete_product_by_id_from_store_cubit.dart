// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/use_cases/delete_product_use_case.dart';

// part 'delete_product_by_id_from_store_state.dart';

// class DeleteProductByIdFromStoreCubit
//     extends Cubit<DeleteProductByIdFromStoreState> {
//   DeleteProductByIdFromStoreCubit(this.deleteProductByIdUseCase)
//       : super(DeleteProductByIdFromStoreInitial());
//   final DeleteProductUseCase deleteProductByIdUseCase;

//   // for delete product
//   Future<void> deleteProductById({required int productId}) async {
//     emit(DeleteProductByIdFromStoreLoading());

//     var params = DeleteProductByIdPara(productId);
//     var result = await deleteProductByIdUseCase.execute(params);

//     result.fold(
//         // left
//         (failure) {
//       emit(DeleteProductByIdFromStoreFailure(errMessage: failure.message));
//     },
//         // right
//         (responseMessage) {
//       emit(DeleteProductByIdFromStoreSuccess(message: responseMessage.message));
//     });
//   }
// }
