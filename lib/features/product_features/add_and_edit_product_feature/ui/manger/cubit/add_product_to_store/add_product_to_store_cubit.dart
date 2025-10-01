import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';
import '../../../../../../../core/errors/failure.dart';
import '../../../../domain/use_cases/add_product_to_store_use_case.dart';
part 'add_product_to_store_state.dart';

class AddProductToStoreCubit extends Cubit<AddProductToStoreState> {
  AddProductToStoreCubit(this.addProductToStoreUseCase)
      : super(AddProductToStoreInitial());

  final AddProductToStoreUseCase addProductToStoreUseCase;

  // all controller for [ info product ] ==> add product page
  TextEditingController nameProductController = TextEditingController();
  TextEditingController numberProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();

  // all File for [ product Images ] ==> add product page
  File? mainImageProductFile;
  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;

  // all num for [ Type product ] ==> add product page
  int? selectedMainCategoryId;
  int? selectedSubCategoryId;
  int? selectedBrandId;

  // all fields for [ Attribute product ] ==> add product page
  List<TextEditingController> keys = [];
  List<TextEditingController> values = [];

  //temp method for testing paganated dropdown list
  void changeMainCategoryId(int? value) {
    selectedMainCategoryId = value;
    
    emit(ChangeMainCategoryIdState(seleted: value != null));
  }
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

  Future<void> addProductToStore(
      List<String> tags, String shortDescription, num oldPrice) async {
    emit(AddProductToStoreLoading()); // ======== emit ==========
    AddProductToStoreParams params = AddProductToStoreParams(
      name: nameProductController.text,
      oldPrice: oldPrice,
      shortDescription: shortDescription,
      tags: tags,
      price: num.parse(priceProductController.text),
      description: descriptionProductController.text,
      mainImageFile: mainImageProductFile!,
      number: numberProductController.text,
      storeId: null,
      offerId: null,
      brandId: selectedBrandId,
      mainCategoryId: selectedMainCategoryId!,
      images: [
        if (subOneImageProductFile != null) subOneImageProductFile!,
        if (subTwoImageProductFile != null) subTwoImageProductFile!,
        if (subThreeImageProductFile != null) subThreeImageProductFile!,
      ],
      subCategoryIds: [selectedSubCategoryId!],
      newAttributes: [
        for (int i = 0; i < keys.length; i++)
          {"attributeName": keys[i].text, "attributeValue": values[i].text}
      ],
    );
    Either<Failure, AddProductEntity> result =
        await addProductToStoreUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(AddProductToStoreFailure(
          errMessage: failure.message)); // ======== emit ==========
    },
        // right
        (message) {
      emit(AddProductToStoreSuccess(
          message: message)); // ======== emit ==========
    });
  }
}
