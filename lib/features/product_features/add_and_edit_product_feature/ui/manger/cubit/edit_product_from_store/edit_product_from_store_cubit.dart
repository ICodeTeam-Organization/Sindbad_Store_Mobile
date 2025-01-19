import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/edit_product_entities/edit_product_entity.dart';
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

  // all num for [ Type product ] ==> Edit product page
  bool isInitialDropDown = true;
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

  // void updateIsInitialDropDown() {
  //   isInitialDropDown = false;
  // }

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

  void editProductFromStore({
    required int productId,
    required TextEditingController priceProductController,
    required TextEditingController descriptionProductController,
    required List<TextEditingController> keys,
    required List<TextEditingController> values,
  }) async {
    emit(EditProductFromStoreLoading());
    EditProductFromStoreParams params = EditProductFromStoreParams(
      id: productId,
      price: num.parse(priceProductController.text),
      description: priceProductController.text,
      mainImageFile: mainImageProductFile,
      storeId: null,
      offerId: null,
      brandId: selectedBrandId,
      mainCategoryId: selectedMainCategoryId!,
      images: (subOneImageProductFile == null &&
              subTwoImageProductFile == null &&
              subThreeImageProductFile == null)
          ? null // if all null => will save [Basic images] for product
          : [
              if (subOneImageProductFile != null) subOneImageProductFile!,
              if (subTwoImageProductFile != null) subTwoImageProductFile!,
              if (subThreeImageProductFile != null) subThreeImageProductFile!
            ],
      subCategoryIds: [selectedMainCategoryId!],
      newAttributes: [
        for (int i = 0; i < keys.length; i++)
          {"attributeName": keys[i].text, "attributeValue": values[i].text}
      ],
    );

    Either<Failure, EditProductEntity> result =
        await editProductFromStoreUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(EditProductFromStoreFailure(
          errMessage: failure.message)); // ======== emit ==========
    },
        // right
        (message) {
      emit(EditProductFromStoreSuccess(
          message: message)); // ======== emit ==========
    });
  }
}
