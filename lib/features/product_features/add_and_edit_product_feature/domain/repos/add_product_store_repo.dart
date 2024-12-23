import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/main_category_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/add_product_entity.dart';
import '../entities/brand_entity.dart';

abstract class AddProductStoreRepo {
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
}
