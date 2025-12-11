import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';

abstract class ProductRemoteDataSource {
  // for get MainCategory
  Future<List<MainCategoryForViewEntity>> getMainCategoryForView({
    required int pageNumber,
    required int pageSize,
  });

  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    required List<int>? categoryId,
  });
  Future<List<ProductEntity>> getAllProducts(
    int pageNumber,
    int pageSize,
    List<int>? categoryIdList,
  );
  Future<DeleteProductEntity> deleteProductById(
    int productId,
  );

  // for disable Products By [Ids]
  Future<bool> disableProductsByIds(List<int> ids);

  // for ActivateProducts By [Ids]
  Future<bool> activateProductsByIds(List<int> ids);
}
