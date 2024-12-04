import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_product_to_store_state.dart';

class AddProductToStoreCubit extends Cubit<AddProductToStoreState> {
  AddProductToStoreCubit() : super(AddProductToStoreInitial());

  // all controller for [ info product ] ==> add product page
  TextEditingController nameProductController = TextEditingController();
  TextEditingController numberProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();

  // all File for [ product Images ] ==> add product page
  File? mainImageProduct;
  File? subOneImageProduct;
  File? subTwoImageProduct;
  File? subThreeImageProduct;

  // to pick image from gallery
  Future<void> pickImageFromGallery({required int numPartImage}) async {
    final XFile? galleryImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (galleryImage != null) {
      // try {
      final File pickedImage = File(galleryImage.path);
      switch (numPartImage) {
        case 1:
          mainImageProduct = pickedImage;
          emit(AddImageProductToStoreSuccess());
          break;
        case 2:
          subOneImageProduct = pickedImage;
          emit(AddImageProductToStoreSuccess());
          break;
        case 3:
          subTwoImageProduct = pickedImage;
          emit(AddImageProductToStoreSuccess());
          break;
        case 4:
          subThreeImageProduct = pickedImage;
          emit(AddImageProductToStoreSuccess());
          break;
      }
    }
  }

  // for return image to her box
  File? imageByNumBox({required int numBox}) {
    switch (numBox) {
      case 1:
        return mainImageProduct;
      case 2:
        return subOneImageProduct;
      case 3:
        return subTwoImageProduct;
      case 4:
        return subThreeImageProduct;
    }
    return null;
  }

  // for delete image from box
  void deleteImageByNumBox({required int numBox}) {
    switch (numBox) {
      case 1:
        mainImageProduct = null;
        emit(AddImageProductToStoreSuccess());
      case 2:
        subOneImageProduct = null;
        emit(AddImageProductToStoreSuccess());
      case 3:
        subTwoImageProduct = null;
        emit(AddImageProductToStoreSuccess());
      case 4:
        subThreeImageProduct = null;
        emit(AddImageProductToStoreSuccess());
    }
  }
}
