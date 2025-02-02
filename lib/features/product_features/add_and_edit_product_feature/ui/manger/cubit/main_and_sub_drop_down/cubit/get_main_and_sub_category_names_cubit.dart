import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../../../../core/errors/failure.dart';
import '../../../../../domain/entities/add_product_entities/sub_category_entity.dart';
import '../../../../../domain/use_cases/get_main_and_sub_category_use_case.dart';
part 'get_main_and_sub_category_names_state.dart';

class GetCategoryNamesCubit extends Cubit<GetCategoryNamesState> {
  GetCategoryNamesCubit(this.getMainAndSubCategoryUseCase)
      : super(GetCategoryNamesInitial());

  final GetMainAndSubCategoryUseCase getMainAndSubCategoryUseCase;

  List<MainCategoryEntity> mainAndSubCategories =
      []; // to store main and sub categories
  List<SubCategoryEntity> selectedSubCategories =
      []; // to store just sub categories

  // for drop down category

  Future<void> getMainAndSubCategory({
    required int filterType,
    required int pageNumber,
    required int pageSize,
  }) async {
    emit(GetCategoryNamesLoading());
    GetMainAndSubCategoryParams params = GetMainAndSubCategoryParams(
        filterType: filterType, pageNumber: pageNumber, pageSize: pageSize);

    Either<Failure, List<MainCategoryEntity>> result =
        await getMainAndSubCategoryUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      if (!isClosed) {
        emit(GetCategoryNamesFailure(errMessage: failure.message));
      }
    },
        // right
        (mainAndSubCategory) {
      // to store in cubit class
      mainAndSubCategories = mainAndSubCategory;
      if (!isClosed) {
        emit(GetCategoryNamesSuccess(
            categoryAndSubCategoryNames: mainAndSubCategory));
      }
    });
  }

  // هذي سويتها لصفحة الاضافة وماقدرت استخدمها في التعديل
  // عند اختيار فئة رئيسية، تحديث الفئات الفرعية
  void updateSubCategories(int selectedMainCategoryId) {
    try {
      final selectedMainCategory = mainAndSubCategories.firstWhere(
        (category) => category.mainCategoryId == selectedMainCategoryId,
      );
      // selectedSubCategories = contains just sub categories for mainCategories specific by ID
      selectedSubCategories = selectedMainCategory.subCategory;
    } catch (e) {
      selectedSubCategories = [];
    }

    emit(GetCategoryNamesSuccess(
      categoryAndSubCategoryNames: mainAndSubCategories,
    ));
  }
}
