import 'dart:io';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/product_details_entity.dart';

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

  // ==================== Add/Edit Product Methods ====================

  // Add product to store
  Future<AddProductEntity> addProductToStore({
    required String name,
    required num price,
    required String description,
    required File mainImageFile,
    required String number,
    required int mainCategoryId,
    required List<int> subCategoryIds,
    int? storeId,
    int? offerId,
    int? brandId,
    List<File>? images,
    List<Map<String, String>>? newAttributes,
    List<String>? tags,
    num? oldPrice,
    String? shortDescription,
    String? token,
  });

  // Edit product from store
  Future<EditProductEntity> editProductFromStore({
    required int id,
    required num price,
    required String description,
    required File? mainImageFile,
    required int? storeId,
    required int? offerId,
    required int? brandId,
    required int mainCategoryId,
    required List<File>? images,
    required List<String>? imagesUrl,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
    required num? oldPrice,
    required String? shortDescription,
    required List<String>? tags,
  });

  // Get main and sub categories
  Future<List<CategoryEntity>> getMainAndSubCategory({String? updatedAt});

  // Get brands by main category ID
  Future<List<BrandEntity>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
  });

  // Get product details
  Future<ProductDetailsEntity> getProductDetails({
    required int productId,
  });
}
