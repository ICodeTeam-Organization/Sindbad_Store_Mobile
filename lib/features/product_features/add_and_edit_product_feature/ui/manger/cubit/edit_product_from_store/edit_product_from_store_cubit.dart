import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/edit_product_from_store_use_case.dart';
part 'edit_product_from_store_state.dart';

class EditProductFromStoreCubit extends Cubit<EditProductFromStoreState> {
  final EditProductFromStoreUseCase editProductFromStoreUseCase;

  EditProductFromStoreCubit(this.editProductFromStoreUseCase)
      : super(EditProductFromStoreInitial());

  // all fields for [ Attribute product ] ==> Edit product page
  // List<TextEditingController> keys = [];
  // List<TextEditingController> values = [];

  // // all controller for [ info product ] ==> add product page
  // TextEditingController nameProductController = TextEditingController();
  // TextEditingController numberProductController = TextEditingController();
  // TextEditingController priceProductController = TextEditingController();
  // TextEditingController descriptionProductController = TextEditingController();

  // // all File for [ product Images ] ==> add product page
  // String? mainImageProduct;
  // String? subOneImageProduct;
  // String? subTwoImageProduct;
  // String? subThreeImageProduct;
  // // all File for [ product Images ] ==> add product page
  File? mainImageProductFile;
  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;

  // // all num for [ Type product ] ==> add product page
  int? selectedMainCategoryId;
  int? selectedSubCategoryId;
  int? selectedBrandId;
  void testDropDown() {
    print("=======================  testDropDown  =====================");
    print("تم اختيار الفئة الرئيسية: ID = $selectedMainCategoryId");
    print("تم اختيار الفئة الفرعية: ID = $selectedSubCategoryId");
    print("تم اختيار البراند: ID = $selectedBrandId");
    print("=======================  testDropDown  =====================");
  }

  // // all fileds for [ Attribute product ] ==> add product page
  // List<TextEditingController> keys = [];
  // List<TextEditingController> values = [];

  // for set Image variables = value
  void saveImageInCubit({required int boxNum, required File? file}) {
    switch (boxNum) {
      case 1:
        mainImageProductFile = file;
        break;
      case 2:
        subOneImageProductFile = file;
        break;
      case 3:
        subTwoImageProductFile = file;
        break;
      case 4:
        subThreeImageProductFile = file;
        break;
    }
  }

  // for set Image variables = value
  void deleteImageFromCubit({required int boxNum}) {
    switch (boxNum) {
      case 1:
        mainImageProductFile = null;
        break;
      case 2:
        subOneImageProductFile = null;
        break;
      case 3:
        subTwoImageProductFile = null;
        break;
      case 4:
        subThreeImageProductFile = null;
        break;
    }
  }

  // for test Post Request
  void testEditProductRequest({
    required String? priceProductController,
    required String? descriptionProductController,
    required List<TextEditingController> keys,
    required List<TextEditingController> values,
  }) {
    debugPrint(
        "=======================  test Edit Product Request  =====================");
    debugPrint("priceProduct =>                 $priceProductController");
    debugPrint("descriptionProduct =>           $descriptionProductController");
    debugPrint(
        "mainImageProduct =>             ${path.basename(mainImageProductFile?.path ?? 'لايوجد')}");
    debugPrint(
        "subOneImageProduct =>           ${path.basename(subOneImageProductFile?.path ?? 'لايوجد')}");
    debugPrint(
        "subTwoImageProduct =>           ${path.basename(subTwoImageProductFile?.path ?? 'لايوجد')}");
    debugPrint(
        "subThreeImageProduct =>         ${path.basename(subThreeImageProductFile?.path ?? 'لايوجد')}");
    debugPrint("MainCategoryId =>               $selectedMainCategoryId");
    debugPrint("SubCategoryId =>                $selectedSubCategoryId");
    debugPrint("BrandId =>                      $selectedBrandId");
    // for (int i = 0; i < keys.length; i++) {
    //   debugPrint("key ${i + 1} =>                        ${keys[i].text}");
    //   debugPrint("value ${i + 1} =>                      ${values[i].text}");
    // }
    debugPrint([
      for (int i = 0; i < keys.length; i++)
        {"attributeName": keys[i].text, "attributeValue": values[i].text}
    ].toString());
    debugPrint(
        "=======================  test Edit Product Request  =====================");
  }

  // void addProductToStore() async {
  //   emit(AddProductToStoreLoading()); // ======== emit ==========
  //   print("===========  جاررررررررررررري التحميييييل  =========");
  //   AddProductToStoreParams params = AddProductToStoreParams(
  //     name: nameProductController.text,
  //     price: num.parse(priceProductController.text),
  //     description: descriptionProductController.text,
  //     mainImageFile: mainImageProductFile!,
  //     number: numberProductController.text,
  //     storeId: null,
  //     offerId: null,
  //     brandId: selectedBrandId,
  //     mainCategoryId: selectedMainCategoryId!,
  //     images: [
  //       if (subOneImageProductFile != null) subOneImageProductFile!,
  //       if (subTwoImageProductFile != null) subTwoImageProductFile!,
  //       if (subThreeImageProductFile != null) subThreeImageProductFile!,
  //     ],
  //     subCategoryIds: [selectedSubCategoryId!],
  //     newAttributes: [
  //       for (int i = 0; i < keys.length; i++)
  //         {"attributeName": keys[i].text, "attributeValue": values[i].text}
  //     ],
  //   );
  //   print("============================  in cubit  ==========================");
  //   Either<Failure, AddProductEntity> result =
  //       await addProductToStoreUseCase.execute(params);

  //   result.fold(
  //       // left
  //       (failure) {
  //     print("===========  فشششششششششل التحميييييل  =========");
  //     print("===========  ${failure.message} =========");
  //     print("===========  فشششششششششل التحميييييل  =========");
  //     emit(AddProductToStoreFailure(
  //         errMessage: failure.message)); // ======== emit ==========
  //   },
  //       // right
  //       (message) {
  //     print("===========  تمت الإضافة بنجاح =========");
  //     print("=========== success =>  ${message.success} =========");
  //     print("=========== message =>  ${message.message} =========");
  //     print("===========  تمت الإضافة بنجاح =========");
  //     emit(AddProductToStoreSuccess(
  //         message: message)); // ======== emit ==========
  //   });
  // }
}
