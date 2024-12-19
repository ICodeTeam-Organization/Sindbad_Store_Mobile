import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/main_category_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../entities/brand_entity.dart';

abstract class AddProductStoreRepo {
  Future<Either<Failure, List<MainCategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  });
  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int mainCategoryId,
  });
}
