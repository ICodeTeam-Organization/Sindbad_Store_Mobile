import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/add_product_entities/add_product_entity.dart';
import '../entities/add_product_entities/brand_entity.dart';
import '../entities/edit_product_entities/edit_product_entity.dart';
import '../entities/edit_product_entities/product_details_entity.dart';

abstract class AddAndEditProductStoreRepo {
  Future<Either<Failure, AddProductEntity>> addProductToStore({
    required String name,
    required num price,
    required String description,
    required File mainImageFile,
    required String number,
    // i don't know what data type and value
    required int? storeId,
    required int? offerId,
    required int? brandId,
    //
    required int mainCategoryId,
    required List<File> images,
    required List<int> subCategoryIds,
    // required List<Map<String, String>> newAttributes,
    required List<Map<String, String>> newAttributes,
    required List<String> tags,
    required num oldPrice,
    required String shortDescription,
  });

  Future<Either<Failure, List<CategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
  });
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails({
    required int productId,
  });
  Future<Either<Failure, EditProductEntity>> editProductFromStore({
    required int id,
    // required String name,     // can't update in this in backend
    required String description,
    required num price,
    // required String number,   // can't update in this in backend
    required File? mainImageFile,
    required int? storeId,
    required int? offerId,
    required int? brandId,
    required int mainCategoryId,
    required List<File>? images,
    required List<String>? imagesUrl,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
    required List<String>? tags,
    required num? oldPrice,
    required String? shortDescription,
  });
}
