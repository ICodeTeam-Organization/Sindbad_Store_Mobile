import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/repos/add_and_edit_product_store_repo.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/add_product_entities/add_product_entity.dart';

class AddProductToStoreUseCase
    extends UseCaseWithParam<AddProductEntity, AddProductToStoreParams> {
  final AddAndEditProductStoreRepoImpl addProductStoreRepo;

  AddProductToStoreUseCase(this.addProductStoreRepo);
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
        tags: params.tags,
        oldPrice: params.oldPrice,
        shortDescription: params.shortDescription);
  }
}

class ProAttribute {
  const ProAttribute({
    required this.attributeName,
    required this.attributeValue,
  });
  final String attributeName;
  final String attributeValue;
}

class AddProductToStoreParams {
  final String name;
  final num price;
  final String description;
  final File mainImageFile;
  final String number;
  // i don't use it
  final int? storeId;
  final int? offerId;
  //
  final int? brandId;
  final int mainCategoryId;
  final List<File> images;
  final List<int> subCategoryIds;
  final List<Map<String, String>> newAttributes;
  final List<String> tags;
  final num oldPrice;
  final String shortDescription;
  AddProductToStoreParams(
      {required this.name,
      required this.price,
      required this.description,
      required this.mainImageFile,
      required this.number,
      //
      required this.storeId,
      required this.offerId,
      //
      required this.brandId,
      required this.mainCategoryId,
      required this.images,
      required this.subCategoryIds,
      required this.newAttributes,
      required this.tags,
      required this.oldPrice,
      required this.shortDescription});
}
