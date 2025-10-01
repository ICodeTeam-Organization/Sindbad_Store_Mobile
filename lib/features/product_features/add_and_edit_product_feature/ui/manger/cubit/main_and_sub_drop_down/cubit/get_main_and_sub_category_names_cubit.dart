import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../../../../core/errors/failure.dart';
import '../../../../../domain/use_cases/get_main_and_sub_category_use_case.dart';
part 'get_main_and_sub_category_names_state.dart';

class GetCategoryNamesCubit extends Cubit<GetCategoryNamesState> {
  GetCategoryNamesCubit(this.getMainAndSubCategoryUseCase)
      : super(GetCategoryNamesInitial());

  final GetMainAndSubCategoryUseCase getMainAndSubCategoryUseCase;

  List<CategoryEntity> mainCategories = []; // to store main and sub categories
  List<CategoryEntity> subCategories = []; // to store just sub categories
  
  // NEW METHOD: Get categories directly without state management
  Future<Either<Failure, List<CategoryEntity>>> getMainAndSubCategoryDirectly({
    required int filterType,
    required int pageNumber,
    required int pageSize,
  }) async {
    GetMainAndSubCategoryParams params = GetMainAndSubCategoryParams(
        filterType: filterType, pageNumber: pageNumber, pageSize: pageSize);

    Either<Failure, List<CategoryEntity>> result =
        await getMainAndSubCategoryUseCase.execute(params);

    return result;
  }

  // for drop down category

  Future<void> getMainAndSubCategory({
    required int filterType,
    required int pageNumber,
    required int pageSize,
  }) async {
    if (pageNumber == 1) {
  emit(GetCategoryNamesLoading());
    } else {
      emit(GetCategoryNamesPaganiationLoading());
}
    GetMainAndSubCategoryParams params = GetMainAndSubCategoryParams(
        filterType: filterType, pageNumber: pageNumber, pageSize: pageSize);

    Either<Failure, List<CategoryEntity>> result =
        await getMainAndSubCategoryUseCase.execute(params);

    result.fold(
        // left
        (failure) {

      if (!isClosed) {
        if (pageNumber == 1) {
          emit(GetCategoryNamesFailure(errMessage: failure.message));
        } else {
          emit(GetCategoryNamesPaganiationFailer(errMessage: failure.message));
        }
}
      
    },
        // right
        (mainAndSubCategory) {
      for (int i = 0; i < mainAndSubCategory.length; i++) {
        if (mainAndSubCategory[i].categoryLevel == 1) {
          mainCategories.add(mainAndSubCategory[i]);
        }
      }
      // to store in cubit class
      mainCategories = mainAndSubCategory;
      if (!isClosed) {
        emit(GetCategoryNamesSuccess(
            categoryAndSubCategoryNames: mainCategories));
      }
    });
  }

  // هذي سويتها لصفحة الاضافة وماقدرت استخدمها في التعديل
  // عند اختيار فئة رئيسية، تحديث الفئات الفرعية
  void updateSubCategories(int selectedMainCategoryId) {
    for (int i = 0; i < mainCategories.length; i++) {
      if (mainCategories[i].categoryParentId == selectedMainCategoryId) {
        subCategories.add(mainCategories[i]);
      }
    }
  }
}
