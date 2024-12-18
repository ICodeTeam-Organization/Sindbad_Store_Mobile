import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_product_to_store_state.dart';

class AddProductToStoreCubit extends Cubit<AddProductToStoreState> {
  AddProductToStoreCubit() : super(AddProductToStoreInitial());

  // all controller for [ info product ] ==> add product page
  TextEditingController nameProductController = TextEditingController();
  TextEditingController numberProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();

  int? selectedMainCategoryId;
  int? selectedSubCategoryId;
  int? selectedBrandId;
  void test() {
    print("=======================  test  =====================");
    print("تم اختيار الفئة الرئيسية: ID = $selectedMainCategoryId");
    print("تم اختيار الفئة الفرعية: ID = $selectedSubCategoryId");
    print("تم اختيار البراند: ID = $selectedBrandId");
    print("=======================  test  =====================");
  }

  // // all File for [ product Images ] ==> add product page
  String? mainImageProduct;
  String? subOneImageProduct;
  String? subTwoImageProduct;
  String? subThreeImageProduct;

  // // for drop down category

  // Map<int, Map<String, List<Map<String, dynamic>>>>
  //     categoryAndSubCategoryNames = {};

  // Future<void> fetchCategories() async {
  //   emit(GetCategoryNamesLoading());
  //   const Map<String, dynamic> data = {
  //     "pageNumber": 0,
  //     "pageSize": 0,
  //     "isStore": true,
  //   };
  //   try {
  //     final Map<String, dynamic> response = await ApiService(Dio())
  //         .post(endPoint: "Store/categories/GetStoreCategories", data: data);

  //     final CategoriesResponseModel categoriesResponse =
  //         CategoriesResponseModel.fromJson(response);
  //     // Iterating over categories to build the map
  //     for (CategoryItem category in categoriesResponse.data.items) {
  //       // إنشاء قائمة للـ subCategories
  //       List<Map<String, dynamic>> subCategoryList =
  //           category.subCategories.map((subCategory) {
  //         return {
  //           'id': subCategory.id,
  //           'name': subCategory.subCategoryName,
  //         };
  //       }).toList();

  //       // إضافة الفئة الرئيسية مع المحتويات الفرعية
  //       categoryAndSubCategoryNames[category.id] = {
  //         category.categoryName: subCategoryList,
  //       };
  //     }
  //     print("======================الراجع من API =========================");
  //     print(categoryAndSubCategoryNames); // فقط للتأكد من صحة البيانات
  //     print("===============================================");
  //     emit(GetCategoryNamesSuccess(
  //         categoryAndSubCategoryNames: categoryAndSubCategoryNames));
  //   } catch (e) {
  //     emit(GetCategoryNamesFailure());
  //     print('Error fetching categories: $e');
  //   }
  // }

  // List<Map<String, dynamic>> getSubCategoriesByMainCategoryId(
  //     int mainCategoryId) {
  //   final mainCategory = categories[mainCategoryId];
  //   if (mainCategory != null) {
  //     return mainCategory.values.first; // قائمة الفئات الفرعية
  //   }
  //   return [];
  // }

  // // to pick image from gallery
  // Future<void> pickImageFromGallery({required int numPartImage}) async {
  //   final XFile? galleryImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (galleryImage != null) {
  //     // try {
  //     final File pickedImage = File(galleryImage.path);
  //     switch (numPartImage) {
  //       case 1:
  //         mainImageProduct = pickedImage;
  //         emit(AddImageProductToStoreSuccess());
  //         break;
  //       case 2:
  //         subOneImageProduct = pickedImage;
  //         emit(AddImageProductToStoreSuccess());
  //         break;
  //       case 3:
  //         subTwoImageProduct = pickedImage;
  //         emit(AddImageProductToStoreSuccess());
  //         break;
  //       case 4:
  //         subThreeImageProduct = pickedImage;
  //         emit(AddImageProductToStoreSuccess());
  //         break;
  //     }
  //   }
  // }

  // // for return image to her box
  // File? imageByNumBox({required int numBox}) {
  //   switch (numBox) {
  //     case 1:
  //       return mainImageProduct;
  //     case 2:
  //       return subOneImageProduct;
  //     case 3:
  //       return subTwoImageProduct;
  //     case 4:
  //       return subThreeImageProduct;
  //   }
  //   return null;
  // }

  // // for delete image from box
  // void deleteImageByNumBox({required int numBox}) {
  //   switch (numBox) {
  //     case 1:
  //       mainImageProduct = null;
  //       emit(AddImageProductToStoreSuccess());
  //     case 2:
  //       subOneImageProduct = null;
  //       emit(AddImageProductToStoreSuccess());
  //     case 3:
  //       subTwoImageProduct = null;
  //       emit(AddImageProductToStoreSuccess());
  //     case 4:
  //       subThreeImageProduct = null;
  //       emit(AddImageProductToStoreSuccess());
  //   }
  // }
}
