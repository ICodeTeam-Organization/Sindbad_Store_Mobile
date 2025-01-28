import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/disable_products_entity.dart';
import '../entities/activate_products_entity.dart';
import '../entities/delete_entity_product.dart';
import '../entities/main_category_for_view_entity.dart';
import '../entities/product_entity.dart';

abstract class ViewProductRepo {
  // for get MainCategory
  Future<Either<Failure, List<MainCategoryForViewEntity>>>
      getMainCategoryForView({
    required int pageNumber,
    required int pageSize,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    required int? categoryId,
  });

  Future<Either<Failure, DeleteProductEntity>> deleteProductById({
    required int productId,
  });

  // for disable Products By [Ids]
  Future<Either<Failure, DisableProductsEntity>> disableProductsByIds(
      {required List<int> ids});

  // for ActivateProducts By [Ids]
  Future<Either<Failure, ActivateProductsEntity>> activateProductsByIds(
      {required List<int> ids});
}
