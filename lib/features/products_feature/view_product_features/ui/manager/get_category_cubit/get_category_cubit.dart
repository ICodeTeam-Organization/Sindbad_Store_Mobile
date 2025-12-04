import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../domain/entities/main_category_for_view_entity.dart';
import '../../../domain/entities/get_main_category_paramers.dart';
import '../../../domain/use_cases/get_main_category_use_case.dart';

part 'get_category_state.dart';

class GetCategory extends Cubit<GetCategoryState> {
  GetCategory(this.getMainCategoryUseCase) : super(GetCategoryInitial());

  final GetMainCategoryUseCase getMainCategoryUseCase;
  List<StoreCategoryModel> _allCategories = [
    StoreCategoryModel(
      id: 0,
      categoryName: 'الكل',
      categoryImageUrl: '',
    )
  ];
  // bool _isFetching = false;

  // Future<void> getMainCategoryForView({
  //   required int pageNumber,
  //   required int pageSize,
  // }) async {
  //   var categoryBox = Hive.box<CategoryEntity>('categotyBox');

  //   if (_isFetching) return;
  //   _isFetching = true;

  //   if (pageNumber == 1) {
  //     emit(GetCategoryLoadInProgress());
  //   } else {
  //     // Immediately emit success with loading flag true (to show loading indicator in list)
  //     emit(GetCategoryLoadSuccess(
  //        ));
  //   }

  //   MainCategoryForViewParams params =
  //       MainCategoryForViewParams(pageNumber: pageNumber, pageSize: pageSize);

  //   // Either<Failure, List<MainCategoryForViewEntity>> result =
  //   //     await getMainCategoryForViewUseCase.execute(params);
  //   Either<Failure, List<StoreCategoryModel>> result =
  //       await getMainCategoryForViewUseCase.execute(params);

  //   // If API returns data, use it and persist into Hive. Otherwise fall back to Hive box.
  //   result.fold(
  //     (failure) {
  //       // On failure: if first page, emit failure; otherwise keep old data
  //       if (pageNumber == 1) {
  //         // Try to read from Hive box as a fallback
  //         if (categoryBox.isNotEmpty) {
  //           // _allCategories = categoryBox.values
  //           //     .map((category) =>
  //           //         StoreCategoryModel.fromCategoryEntity(category))
  //           //     .toList();
  //           emit(GetCategoryLoadSuccess(_allCategories));
  //         } else {
  //           emit(GetCategoryLoadFailure( failure.message));
  //         }
  //       } else {
  //         emit(GetCategoryLoadSuccess( _allCategories));
  //       }
  //     },
  //     (mainCategoryForView) async {
  //       // On success: update local list and persist into Hive
  //       if (pageNumber == 1) {
  //         _allCategories = mainCategoryForView;
  //       } else {
  //         _allCategories.addAll(mainCategoryForView);
  //       }

  //       // Persist categories into Hive for other features that expect them
  //       try {
  //         // Clear existing and add fresh categories
  //         // await categoryBox.clear();
  //         // final categoryEntities = mainCategoryForView.map(
  //         //   (c) => CategoryEntity(
  //         //     categoryId: c.mainCategoryId,
  //         //     categoryName: c.mainCategoryName,
  //         //     categoryImage: '',
  //         //     categoryLevel: 0,
  //         //     categoryParentId: 0,
  //         //     categoryType: 0,
  //         //     isDeleted: false,
  //         //   ),
  //         // );
  //         // await categoryBox.addAll(categoryEntities);
  //       } catch (e) {
  //         // Ignore persistence errors but keep using API data
  //         print('Failed to persist categories to Hive: $e');
  //       }

  //       emit(GetCategoryLoadSuccess(categoryies: _allCategories));
  //     },
  //   );

  //   _isFetching = false;
  // }

  Future<void> getMainCategory(
    int pageNumber,
    int pageSize,
  ) async {
    emit(GetCategoryLoadInProgress());
    //  await Future.delayed(const Duration(seconds: 2));
    emit(GetCategoryLoadSuccess(_allCategories));
    if (pageNumber == 1) {
      emit(GetCategoryLoadInProgress());
      // Reset list to just "ALL" when refreshing
      _allCategories = [
        StoreCategoryModel(
          id: 0,
          categoryName: 'الكل',
          categoryImageUrl: '',
        )
      ];
    }

    MainCategoryParams params =
        MainCategoryParams(pageNumber: pageNumber, pageSize: pageSize);

    if (pageNumber > 1) {
      emit(GetCategoryLoadSuccess(_allCategories));
    }

    var result = await getMainCategoryUseCase.execute(params);

    result.fold(
      (failure) {
        emit(GetCategoryLoadFailure(failure.message));
      },
      (categories) {
        _allCategories.addAll(categories);
        emit(GetCategoryLoadSuccess(_allCategories));
      },
    );
  }
}
