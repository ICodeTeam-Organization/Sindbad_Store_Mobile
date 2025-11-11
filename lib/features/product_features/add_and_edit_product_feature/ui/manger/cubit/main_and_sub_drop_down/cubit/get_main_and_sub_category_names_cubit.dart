import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../../../../core/errors/failure.dart';
import '../../../../../domain/use_cases/get_main_and_sub_category_use_case.dart';
part 'get_main_and_sub_category_names_state.dart';

class GetCategoryNamesCubit extends Cubit<GetCategoryNamesState> {
  GetCategoryNamesCubit(this.getMainAndSubCategoryUseCase)
      : super(GetCategoryNamesInitial());

  final GetMainAndSubCategoryUseCase getMainAndSubCategoryUseCase;
  final FlutterSecureStorage storage = FlutterSecureStorage();

  List<CategoryEntity> mainCategories = []; // to store main and sub categories
  List<CategoryEntity> subCategories = []; // to store just sub categories

  // for drop down category
  var categoryBox = Hive.box<CategoryEntity>('categotyBox');

  Future<void> getMainAndSubCategory() async {
    // if hive box does not Empty,get the date form it
    //other wide fetch from api
    if (categoryBox.isNotEmpty) {
      fetchDataFromHive();
      return;
    } else {
      // fetch from api and sote them in the hive box, so the next time will be fetched from the Hve box
      await fetchDataFromApi();
    }
  }

  Future<String?> getRequestDate() async {
    return await storage.read(key: 'updatedAt');
  }

  void fetchDataFromHive() {
    mainCategories = categoryBox.values.toList();

    emit(GetCategoryNamesSuccess(
        categoryAndSubCategoryNames: categoryBox.values.toList()));
  }

  Future<void> fetchDataFromApi() async {
    emit(GetCategoryNamesLoading());

    //check if there are any update at stored in the storage
    String? lastRequestDate = await getRequestDate();
    Either<Failure, List<CategoryEntity>> result;
    if (lastRequestDate == null) {
      result = await getMainAndSubCategoryUseCase.execute(null);
    } else {
      result = await getMainAndSubCategoryUseCase.execute(lastRequestDate);
    }
    // if (pageNumber == 1) {
    // } else {
    //   emit(GetCategoryNamesPaganiationLoading());
    // }
    //

    result.fold(
        // left
        (failure) {
      if (!isClosed) {
        emit(GetCategoryNamesFailure(errMessage: failure.message));
      }
    },
        // right
        (mainAndSubCategory) {
      for (int i = 0; i < mainAndSubCategory.length; i++) {
        if (mainAndSubCategory[i].categoryLevel == 1) {
          mainCategories.add(mainAndSubCategory[i]);
        }
      }

      // add dara to the Hive storage
      saveToHive(mainAndSubCategory);
      // to store in cubit class
      mainCategories = mainAndSubCategory;
      if (!isClosed) {
        emit(GetCategoryNamesSuccess(
            categoryAndSubCategoryNames: categoryBox.values.toList()));
      }
    });
  }

  void saveToHive(List<CategoryEntity> newData) {
    final box = categoryBox;

    for (final newCat in newData) {
      // find key for an existing item that has the same categoryId
      dynamic foundKey;
      for (final key in box.keys) {
        final item = box.get(key);
        if (item != null && item.categoryId == newCat.categoryId) {
          foundKey = key;
          break;
        }
      }

      if (foundKey == null) {
        // not found -> add using categoryId as key (recommended)
        // This avoids auto-generated keys and makes future updates simpler.
        box.put(newCat.categoryId, newCat);
      } else {
        // found -> replace the stored object with the new immutable object
        box.put(foundKey, newCat);
      }
    }

    print('Hive update complete. total: ${box.values.length}');
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
