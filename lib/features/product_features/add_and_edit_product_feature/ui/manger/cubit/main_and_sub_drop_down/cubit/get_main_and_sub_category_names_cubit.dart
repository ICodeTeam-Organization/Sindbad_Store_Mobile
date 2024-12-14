import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../core/api_service.dart';
import '../../../../../models/test_all_model_for_add.dart';

part 'get_main_and_sub_category_names_state.dart';

class GetCategoryNamesCubit extends Cubit<GetCategoryNamesState> {
  GetCategoryNamesCubit() : super(GetCategoryNamesInitial());

  // for drop down category

  // Fetch categories from API
  int? selectedMainCategoryId;
  int? selectedSubCategoryId;

  Map<int, Map<String, List<Map<String, dynamic>>>>
      categoryAndSubCategoryNames = {};

  // Fetch categories from API
  Future<void> fetchCategories() async {
    emit(GetCategoryNamesLoading());
    const Map<String, dynamic> data = {
      "pageNumber": 0,
      "pageSize": 0,
      "isStore": true,
    };
    try {
      final Map<String, dynamic> response = await ApiService(Dio())
          .post(endPoint: "Store/categories/GetStoreCategories", data: data);

      final CategoriesResponseModel categoriesResponse =
          CategoriesResponseModel.fromJson(response);
      // Iterating over categories to build the map
      for (CategoryItem category in categoriesResponse.data.items) {
        // إنشاء قائمة للـ subCategories
        List<Map<String, dynamic>> subCategoryList =
            category.subCategories.map((subCategory) {
          return {
            'id': subCategory.id,
            'name': subCategory.subCategoryName,
          };
        }).toList();

        // إضافة الفئة الرئيسية مع المحتويات الفرعية
        categoryAndSubCategoryNames[category.id] = {
          category.categoryName: subCategoryList,
        };
      }
      print("======================الراجع من API =========================");
      print(categoryAndSubCategoryNames); // فقط للتأكد من صحة البيانات
      print("===============================================");
      emit(GetCategoryNamesSuccess(
          categoryAndSubCategoryNames: categoryAndSubCategoryNames));
    } catch (e) {
      emit(GetCategoryNamesFailure());
      print('Error fetching categories: $e');
    }
  }

  // Get subcategories for a selected main category
  List<Map<String, dynamic>> getSubCategoriesByMainCategoryId(
      {required int mainCategoryId}) {
    final mainCategory = categoryAndSubCategoryNames[mainCategoryId];
    if (mainCategory != null) {
      return mainCategory.values.first;
    }
    return [];
  }

// تحديث الفئة الرئيسية المختارة
  void updateSelectedMainCategory(String mainCategoryName) {
    for (var entry in categoryAndSubCategoryNames.entries) {
      if (entry.value.keys.first == mainCategoryName) {
        selectedMainCategoryId = entry.key;
        // هنا تم التعديل: تعيين الفئة الفرعية الأولى تلقائيًا
        final firstSubCategory =
            entry.value.values.first.first; // الحصول على الفئة الفرعية الأولى
        selectedSubCategoryId =
            firstSubCategory['id']; // تعيين الـ ID للفئة الفرعية الأولى

        print("تم اختيار الفئة الرئيسية: ID = $selectedMainCategoryId");
        print("تم اختيار الفئة الفرعية الأولى: ID = $selectedSubCategoryId");
// طباعة الـ ID
        emit(GetCategoryNamesMainCategoryUpdated());
        break;
      }
    }
  }

  // Update selected subcategory
  void updateSelectedSubCategory(String subCategoryName) {
    if (selectedMainCategoryId != null) {
      final subCategories = getSubCategoriesByMainCategoryId(
          mainCategoryId: selectedMainCategoryId!);
      for (var subCategory in subCategories) {
        if (subCategory['name'] == subCategoryName) {
          selectedSubCategoryId = subCategory['id'];
          print(
              "تم اختيار الفئة الفرعية: ID = $selectedSubCategoryId"); // طباعة الـ ID
          // emit(GetCategoryNamesSubCategoryUpdated());
          break;
        }
      }
    }
  }

  void vv() {
    print("=======================  vv  =====================");
    print("تم اختيار الفئة الرئيسية: ID = $selectedMainCategoryId");
    print("تم اختيار الفئة الفرعية: ID = $selectedSubCategoryId");
    print("=======================  vv  =====================");
  }
}
