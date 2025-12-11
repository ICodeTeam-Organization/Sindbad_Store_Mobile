import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/product_remote_data_source_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';

import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/store_data_source_impl.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../../domain/repos/product_store_repository.dart';
import 'package:hive/hive.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSourceImpl productRemoteDataSource;
  final StoreDataSourceImpl storeDataSource;
  ProductRepositoryImpl(this.productRemoteDataSource, this.storeDataSource);
  @override
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory() async {
    try {
      var data = await storeDataSource.getStoreCategories();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // New method: getCategories with pagination and local cache
  @override
  Future<Either<Failure, List<StoreCategoryModel>>> getCategories(
    int pageNumber,
    int pageSize,
  ) async {
    const String boxName = 'categoryBox';
    final box = await Hive.openBox<List<dynamic>>(boxName);
    final String cacheKey = 'page_${pageNumber}_size_$pageSize';

    // Try local cache first
    if (box.containsKey(cacheKey)) {
      final cached = box.get(cacheKey) as List<dynamic>;
      return right(cached.cast<StoreCategoryModel>());
    }

    // Fallback to remote source (fetch all categories)
    final remoteResult = await getStoreCategory();
    return remoteResult.fold(
      (failure) => left(failure),
      (allCategories) {
        final start = (pageNumber - 1) * pageSize;
        if (start >= allCategories.length) {
          box.put(cacheKey, []);
          return right(<StoreCategoryModel>[]);
        }
        final end = (start + pageSize) > allCategories.length
            ? allCategories.length
            : start + pageSize;
        final pageData = allCategories.sublist(start, end);
        box.put(cacheKey, pageData);
        return right(pageData);
      },
    );
  }

  // ===================  for Main Category For View  ====================
  @override
  Future<Either<Failure, List<MainCategoryForViewEntity>>>
      getMainCategoryForView(
          {required int pageNumber, required int pageSize}) async {
    try {
      var data = await productRemoteDataSource.getMainCategoryForView(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    required int? categoryId,
  }) async {
    try {
      var data = await productRemoteDataSource.getProductsByFilter(
        storeProductsFilter: storeProductsFilter,
        pageNumber: pageNumber,
        pageSize: pageSize,
        categoryId: [],
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts(
      int pageNumber, int pageSize, int? categoryId) async {
    try {
      final products = await productRemoteDataSource.getAllProducts(
        pageNumber,
        pageSize,
        categoryId != null ? [categoryId] : null,
      );

      return right(products);
    } on DioException catch (dioError) {
      return left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeleteProductEntity>> deleteProductById(
      int productId) async {
    try {
      var data = await productRemoteDataSource.deleteProductById(
        productId,
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // ===================  for Disable Products  ====================
  @override
  Future<Either<Failure, bool>> disableProductsByIds(List<int> ids) async {
    try {
      var response = await productRemoteDataSource.disableProductsByIds(ids);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // ===================  for Activate Products  ====================
  @override
  Future<Either<Failure, bool>> activateProducts(List<int> ids) async {
    try {
      var response = await productRemoteDataSource.activateProductsByIds(ids);
      return right(response);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
