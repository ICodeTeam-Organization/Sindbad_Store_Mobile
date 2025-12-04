import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';

import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../entities/activate_products_entity.dart';
import 'package:hive/hive.dart';
import '../entities/delete_entity_product.dart';
import '../entities/main_category_for_view_entity.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  // for get MainCategory
  Future<Either<Failure, List<MainCategoryForViewEntity>>>
      getMainCategoryForView({
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    required int? categoryId,
  });
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
    int pageNumber,
    int pageSize,
    int? categoryIdesList,
  );

  Future<Either<Failure, DeleteProductEntity>> deleteProductById({
    required int productId,
  });

  // for disable Products By [Ids]
  Future<Either<Failure, bool>> disableProductsByIds(List<int> ids);

  // for ActivateProducts By [Ids]
  Future<Either<Failure, ActivateProductsEntity>> activateProductsByIds(
      {required List<int> ids});
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory();
  Future<Either<Failure, List<StoreCategoryModel>>> getCategories(
    int pageNumber,
    int pageSize,
  );
}
