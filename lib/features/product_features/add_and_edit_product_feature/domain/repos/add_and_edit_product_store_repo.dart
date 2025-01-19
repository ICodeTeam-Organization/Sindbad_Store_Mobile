import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/usecases/add_product_to_store_use_case.dart';
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
    // i don't know what data tybe and value
    required int? storeId,
    required int? offerId,
    required int? brandId,
    //
    required int mainCategoryId,
    required List<File> images,
    required List<int> subCategoryIds,
    // required List<Map<String, String>> newAttributes,
    required List<Map<String, String>> newAttributes,
  });

  Future<Either<Failure, List<MainCategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  });

  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int mainCategoryId,
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
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
  });
}
