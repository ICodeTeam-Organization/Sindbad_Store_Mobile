import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/main_category_for_view_entity.dart';
import '../../../domain/usecases/get_main_category_for_view_use_case.dart';

part 'get_main_category_for_view_state.dart';

class GetMainCategoryForViewCubit extends Cubit<GetMainCategoryForViewState> {
  GetMainCategoryForViewCubit(this.getMainCategoryForViewUseCase)
      : super(GetMainCategoryForViewInitial());

  final GetMainCategoryForViewUseCase getMainCategoryForViewUseCase;

  Future<void> getMainCategoryForView({
    required int pageNumper,
    required int pageSize,
  }) async {
    emit(GetMainCategoryForViewLoading());
    MainCategoryForViewParams params =
        MainCategoryForViewParams(pageNumper: pageNumper, pageSize: pageSize);

    Either<Failure, List<MainCategoryForViewEntity>> result =
        await getMainCategoryForViewUseCase.execute(params);
    result.fold(
        // left
        (failure) {
      emit(GetMainCategoryForViewFailure(errMessage: failure.message));
    },
        // right
        (mainCategoryForView) {
      print("==========  in cubit get main categoty for view  =========");
      print(
          "==========  ${mainCategoryForView[0].mainCategoryName}  =========");
      print(
          "==========  ${mainCategoryForView[1].mainCategoryName}  =========");
      print("==========  in cubit get main categoty for view  =========");

      emit(GetMainCategoryForViewSuccess(
          mainCategoryForViewEntity: mainCategoryForView));
    });
  }
}
