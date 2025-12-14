import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/add_product_entities/brand_entity.dart';

abstract class AddAndEditProductStoreRepo {
  Future<Either<Failure, List<CategoryEntity>>> getMainAndSubCategory(
      String? updatedAt);

  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
  });
}
