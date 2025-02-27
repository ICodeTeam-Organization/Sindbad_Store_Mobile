import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/main_category_for_view_entity.dart';
import '../../../domain/use_cases/get_main_category_for_view_use_case.dart';

part 'get_main_category_for_view_state.dart';

class GetMainCategoryForViewCubit extends Cubit<GetMainCategoryForViewState> {
  GetMainCategoryForViewCubit(this.getMainCategoryForViewUseCase)
      : super(GetMainCategoryForViewInitial());

  final GetMainCategoryForViewUseCase getMainCategoryForViewUseCase;
  List<MainCategoryForViewEntity> _allCategories = [];
  bool _isFetching = false;

  Future<void> getMainCategoryForView({
    required int pageNumber,
    required int pageSize,
  }) async {
    if (_isFetching) return;
    _isFetching = true;

    if (pageNumber == 1) {
      emit(GetMainCategoryForViewLoading());
    } else {
      // Immediately emit success with loading flag true (to show loading indicator in list)
      emit(GetMainCategoryForViewSuccess(
          mainCategoryForViewEntity: _allCategories, isLoadingMore: true));
    }

    MainCategoryForViewParams params =
        MainCategoryForViewParams(pageNumber: pageNumber, pageSize: pageSize);

    Either<Failure, List<MainCategoryForViewEntity>> result =
        await getMainCategoryForViewUseCase.execute(params);

    result.fold(
      // On failure
      (failure) {
        if (pageNumber == 1) {
          emit(GetMainCategoryForViewFailure(errMessage: failure.message));
        } else {
          // For pagination failure, keep the old data without loading flag
          emit(GetMainCategoryForViewSuccess(
              mainCategoryForViewEntity: _allCategories));
        }
      },
      // On success
      (mainCategoryForView) {
        if (pageNumber == 1) {
          _allCategories = mainCategoryForView;
        } else {
          _allCategories.addAll(mainCategoryForView);
        }
        emit(GetMainCategoryForViewSuccess(
            mainCategoryForViewEntity: _allCategories));
      },
    );

    _isFetching = false;
  }
}
