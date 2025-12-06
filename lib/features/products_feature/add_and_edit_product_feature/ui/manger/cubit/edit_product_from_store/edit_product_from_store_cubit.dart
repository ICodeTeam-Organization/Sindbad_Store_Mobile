import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../domain/entities/edit_product_entities/edit_product_entity.dart';
import '../../../../domain/use_cases/edit_product_from_store_use_case.dart';
part 'edit_product_from_store_state.dart';

class EditProductFromStoreCubit extends Cubit<EditProductFromStoreState> {
  final EditProductFromStoreUseCase editProductFromStoreUseCase;

  EditProductFromStoreCubit(this.editProductFromStoreUseCase)
      : super(EditProductFromStoreInitial());

  // all File for [ product Images ] ==> Edit product page
  File? mainImageProductFile;

  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;

  String? subOneImageProductUrl; // for just save [basic sub images]
  String? subTwoImageProductUrl;
  String? subThreeImageProductUrl;
  List<String> subLeftImageProductUrl = [];

  // all num for [ Type product ] ==> Edit product page
  bool isInitialDropDown = true;
  int? selectedMainCategoryId;
  int? selectedSubCategoryId;
  int? selectedBrandId;

  void saveBasicSubImages({required List<String> basicSubImages}) {
    if (basicSubImages.isNotEmpty) {
      switch (basicSubImages.length) {
        case 1:
          subOneImageProductUrl = basicSubImages[0];
          break;
        case 2:
          subOneImageProductUrl = basicSubImages[0];
          subTwoImageProductUrl = basicSubImages[1];
          break;
        case 3:
          subOneImageProductUrl = basicSubImages[0];
          subTwoImageProductUrl = basicSubImages[1];
          subThreeImageProductUrl = basicSubImages[2];
          break;
        case > 3:
          subOneImageProductUrl = basicSubImages[0];
          subTwoImageProductUrl = basicSubImages[1];
          subThreeImageProductUrl = basicSubImages[2];
          subLeftImageProductUrl = basicSubImages.skip(3).toList();
      }
    }
  }

  // for set Image variables = value
  void saveImageInCubit({required int boxNum, required File? file}) {
    switch (boxNum) {
      case 1:
        mainImageProductFile = file;
        break;
      case 2:
        subOneImageProductFile = file;
        subOneImageProductUrl = null;
        break;
      case 3:
        subTwoImageProductFile = file;
        subTwoImageProductUrl = null;
        break;
      case 4:
        subThreeImageProductFile = file;
        subThreeImageProductUrl = null;
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
        subOneImageProductUrl = null;
        break;
      case 3:
        subTwoImageProductFile = null;
        subTwoImageProductUrl = null;

        break;
      case 4:
        subThreeImageProductFile = null;
        subThreeImageProductUrl = null;
        break;
    }
  }

  Future<void> editProductFromStore({
    required int productId,
    required TextEditingController priceProductController,
    required TextEditingController descriptionProductController,
    required List<TextEditingController> keys,
    required List<TextEditingController> values,
    required TextEditingController? oldPriceController,
    required TextEditingController? shortDescriptionProductController,
    required List<String> tags,
  }) async {
    emit(EditProductFromStoreLoading());
    final List<File> allSubImageProductFile = [
      if (subOneImageProductFile != null) subOneImageProductFile!,
      if (subTwoImageProductFile != null) subTwoImageProductFile!,
      if (subThreeImageProductFile != null) subThreeImageProductFile!
    ];

    final List<String> lstForUiOnly = [
      if (subOneImageProductUrl != null) subOneImageProductUrl!,
      if (subTwoImageProductUrl != null) subTwoImageProductUrl!,
      if (subThreeImageProductUrl != null) subThreeImageProductUrl!
    ];
    final List<String> allSubImageProductUrl = lstForUiOnly;
    allSubImageProductUrl
        .addAll(subLeftImageProductUrl); // add all [ left basic images ]

    EditProductFromStoreParams params = EditProductFromStoreParams(
      id: productId,
      price: num.parse(priceProductController.text),
      description: descriptionProductController.text,
      mainImageFile: mainImageProductFile,
      storeId: null,
      offerId: null,
      brandId: selectedBrandId,
      oldPrice: oldPriceController != null
          ? num.tryParse(oldPriceController.text)
          : null,
      shortDescription: shortDescriptionProductController?.text,

      tags: tags,
      mainCategoryId:
          selectedMainCategoryId!, // if = null in backend meaning the basic image
      images: allSubImageProductFile.isNotEmpty ? allSubImageProductFile : null,
      imagesUrl:
          allSubImageProductUrl.isNotEmpty ? allSubImageProductUrl : null,
      subCategoryIds: [selectedSubCategoryId!],
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
      emit(EditProductFromStoreFailure(errMessage: failure.message));
    },
        // right
        (message) {
      emit(EditProductFromStoreSuccess(message: message));
    });
  }
}
