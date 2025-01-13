import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../../../../core/errors/failure.dart';
import '../../../../../domain/entities/add_product_entities/sub_category_entity.dart';
import '../../../../../domain/usecases/get_main_and_sub_category_use_case.dart';

part 'get_main_and_sub_category_names_state.dart';

class GetCategoryNamesCubit extends Cubit<GetCategoryNamesState> {
  GetCategoryNamesCubit(this.getMainAndSubCategoryUseCase)
      : super(GetCategoryNamesInitial());

  final GetMainAndSubCategoryUseCase getMainAndSubCategoryUseCase;

  List<MainCategoryEntity> mainAndSubCategories =
      []; // لتخزين الفئات الرئيسية والفرعية
  List<SubCategoryEntity> selectedSubCategories = []; // لتخزين الفئات الفرعية

  // for drop down category

  Future<void> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    emit(GetCategoryNamesLoading()); // ======== emit ==========
    GetMainAndSubCategoryParams params = GetMainAndSubCategoryParams(
        filterType: filterType, pageNumper: pageNumper, pageSize: pageSize);

    Either<Failure, List<MainCategoryEntity>> result =
        await getMainAndSubCategoryUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(GetCategoryNamesFailure(
          errMessage: failure.message)); // ======== emit ==========
    },
        // right
        (mainAndSubCategory) {
      //
      // mainAndSubCategories = mainAndSubCategory;
      mainAndSubCategories = mainAndSubCategory;
      //
      emit(GetCategoryNamesSuccess(
          categoryAndSubCategoryNames:
              mainAndSubCategory)); // ======== emit ==========
    });
  }

  // عند اختيار فئة رئيسية، تحديث الفئات الفرعية
  void updateSubCategories(int selectedMainCategoryId) {
    try {
      // نحاول العثور على الفئة الرئيسية
      final selectedMainCategory = mainAndSubCategories.firstWhere(
        (category) => category.mainCategoryId == selectedMainCategoryId,
      );

      // إذا تم العثور على الفئة الرئيسية، نقوم بتحديث الفئات الفرعية
      selectedSubCategories = selectedMainCategory.subCategory;
    } catch (e) {
      // إذا لم يتم العثور على العنصر، نعرض رسالة خطأ أو نستخدم قيمة افتراضية
      selectedSubCategories = []; // نستخدم قائمة فارغة كقيمة افتراضية
    }

    emit(GetCategoryNamesSuccess(
      categoryAndSubCategoryNames: mainAndSubCategories,
    ));
  }
}
