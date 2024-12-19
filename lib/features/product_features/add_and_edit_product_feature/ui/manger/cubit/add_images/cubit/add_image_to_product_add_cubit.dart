import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
part 'add_image_to_product_add_state.dart';

class AddImageToProductAddCubit extends Cubit<AddImageToProductAddState> {
  AddImageToProductAddCubit() : super(AddImageToProductAddInitial());

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
          emit(AddImageToProductAddSuccess());
          break;
        case 2:
          subOneImageProduct = pickedImage;
          emit(AddImageToProductAddSuccess());
          break;
        case 3:
          subTwoImageProduct = pickedImage;
          emit(AddImageToProductAddSuccess());
          break;
        case 4:
          subThreeImageProduct = pickedImage;
          emit(AddImageToProductAddSuccess());
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
        emit(AddImageToProductAddSuccess());
      case 2:
        subOneImageProduct = null;
        emit(AddImageToProductAddSuccess());
      case 3:
        subTwoImageProduct = null;
        emit(AddImageToProductAddSuccess());
      case 4:
        subThreeImageProduct = null;
        emit(AddImageToProductAddSuccess());
    }
  }

  // for return IamgePath
  String? getIamgePath({required int numBox}) {
    switch (numBox) {
      case 1:
        // return mainImageProduct?.path;
        if (mainImageProduct != null) {
          final String imageName = path.basename(mainImageProduct!.path);
          return imageName;
        }
        return null;
      case 2:
        // return subOneImageProduct?.path;
        if (subOneImageProduct != null) {
          final String imageName = path.basename(subOneImageProduct!.path);
          return imageName;
        }
        return null;
      case 3:
        // return subTwoImageProduct?.path;
        if (subTwoImageProduct != null) {
          final String imageName = path.basename(subTwoImageProduct!.path);
          return imageName;
        }
        return null;
      case 4:
        // return subThreeImageProduct?.path;
        if (subThreeImageProduct != null) {
          final String imageName = path.basename(subThreeImageProduct!.path);
          return imageName;
        }
        return null;
    }
    return null;
  }
}
