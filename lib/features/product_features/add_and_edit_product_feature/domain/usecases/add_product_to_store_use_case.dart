import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/repos/add_product_store_repo.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/add_product_entity.dart';

class AddProductToStoreUseCase
    extends UseCaseWithParam<AddProductEntity, AddProductToStoreParams> {
  final AddProductStoreRepo addProductStoreRepo;

  AddProductToStoreUseCase({required this.addProductStoreRepo});
  @override
  Future<Either<Failure, AddProductEntity>> execute(
      AddProductToStoreParams params) {
    return addProductStoreRepo.addProductToStore(
      name: params.name,
      price: params.price,
      description: params.description,
      mainImageFile: params.mainImageFile,
      number: params.number,
      storeId: params.storeId,
      offerId: params.offerId,
      brandId: params.brandId,
      mainCategoryId: params.mainCategoryId,
      images: params.images,
      subCategoryIds: params.subCategoryIds,
      newAttributes: params.newAttributes,
    );
  }
}

class AddProductToStoreParams {
  final String name;
  final num price;
  final String description;
  final File mainImageFile;
  final String number;
  // i don't know what data tybe and value
  final int? storeId;
  final int? offerId;
  final int? brandId;
  //
  final int mainCategoryId;
  final List<File> images;
  final List<int> subCategoryIds;
  final List<Map<String, String>> newAttributes;
  AddProductToStoreParams({
    required this.name,
    required this.price,
    required this.description,
    required this.mainImageFile,
    required this.number,
    //
    required this.storeId,
    required this.offerId,
    required this.brandId,
    //
    required this.mainCategoryId,
    required this.images,
    required this.subCategoryIds,
    required this.newAttributes,
  });
}
