import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';

import '../repos/add_and_edit_product_store_repo.dart';

class EditProductFromStoreUseCase
    extends UseCaseWithParam<EditProductEntity, EditProductFromStoreParams> {
  final AddAndEditProductStoreRepo addAndEditProductStoreRepo;

  EditProductFromStoreUseCase({required this.addAndEditProductStoreRepo});
  @override
  Future<Either<Failure, EditProductEntity>> execute(
      EditProductFromStoreParams params) {
    return addAndEditProductStoreRepo.editProductFromStore(
      id: params.id,
      description: params.description,
      price: params.price,
      mainImageFile: params.mainImageFile,
      storeId: params.storeId,
      offerId: params.offerId,
      brandId: params.brandId,
      mainCategoryId: params.mainCategoryId,
      images: params.images,
      imagesUrl: params.imagesUrl,
      subCategoryIds: params.subCategoryIds,
      newAttributes: params.newAttributes,
    );
  }
}

class EditProductFromStoreParams {
  final int id;
  // final String name;
  final num price;
  final String description;
  final File? mainImageFile;
  // final String number;
  final int? storeId;
  final int? offerId;
  final int? brandId;
  final int mainCategoryId;
  final List<File>? images;
  final List<String>? imagesUrl;
  final List<int> subCategoryIds;
  final List<Map<String, String>> newAttributes;

  EditProductFromStoreParams(
      {required this.id,
      required this.price,
      required this.description,
      required this.mainImageFile,
      required this.storeId,
      required this.offerId,
      required this.brandId,
      required this.mainCategoryId,
      required this.images,
      required this.imagesUrl,
      required this.subCategoryIds,
      required this.newAttributes});
}
