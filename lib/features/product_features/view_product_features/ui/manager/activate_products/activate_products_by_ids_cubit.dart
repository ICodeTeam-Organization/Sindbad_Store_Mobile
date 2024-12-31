import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/activate_products_entity.dart';
import '../../../domain/usecases/activate_products_by_ids_use_case.dart';
part 'activate_products_by_ids_state.dart';

class DisableProductsByIdsCubit extends Cubit<ActivateProductsByIdsState> {
  DisableProductsByIdsCubit(this.activateProductsByIdsUseCase)
      : super(ActivateProductsByIdsInitial());

  final ActivateProductsByIdsUseCase activateProductsByIdsUseCase;

  void activateProductsByIds({required List<int> ids}) async {
    emit(ActivateProductsByIdsLoading());
    ActivateProductsParams params = ActivateProductsParams(ids: ids);

    var result = await activateProductsByIdsUseCase.execute(params);
    result.fold(
        // left
        (failure) {
      emit(ActivateProductsByIdsFailure(errMessage: failure.message));
    },
        // right
        (responseMessage) {
      emit(ActivateProductsByIdsSuccess(message: responseMessage));
    });
  }
}
