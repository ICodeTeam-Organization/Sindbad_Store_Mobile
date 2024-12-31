import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/activate_products_entity.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/disable_products_entity.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/product_entity.dart';
import '../../domain/repos/view_product_store_repo.dart';
import '../data_source/view_product_remote_data_source.dart';

class ViewProductStoreRepoImpl extends ViewProductRepo {
  final ViewProductRemoteDataSource viewProductRemoteDataSource;

  ViewProductStoreRepoImpl({required this.viewProductRemoteDataSource});

  // ===================  for Main Category For View  ====================
  @override
  Future<Either<Failure, List<MainCategoryForViewEntity>>>
      getMainCategoryForView(
          {required int pageNumper, required int pageSize}) async {
    try {
      var data = await viewProductRemoteDataSource.getMainCategoryForView(
        pageNumper: pageNumper,
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
    required int pageNumper,
    required int pageSize,
    required int? categoryId,
  }) async {
    try {
      var data = await viewProductRemoteDataSource.getProductsByFilter(
        storeProductsFilter: storeProductsFilter,
        pageNumper: pageNumper,
        pageSize: pageSize,
        categoryId: categoryId,
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
  Future<Either<Failure, DeleteProductEntity>> deleteProductById(
      {required int productId}) async {
    try {
      var data = await viewProductRemoteDataSource.deleteProductById(
        productId: productId,
      );
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
    // finally {
    //   // to control errMessage when response 404 becouse we can
    //   return left(ServerFailure("المنتج غير موجود."));
    // }
  }

  // ===================  for Disable Products  ====================
  @override
  Future<Either<Failure, DisableProductsEntity>> disableProductsByIds(
      {required List<int> ids}) async {
    try {
      var response =
          await viewProductRemoteDataSource.disableProductsByIds(ids: ids);
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
  Future<Either<Failure, ActivateProductsEntity>> activateProductsByIds(
      {required List<int> ids}) async {
    try {
      var response =
          await viewProductRemoteDataSource.activateProductsByIds(ids: ids);
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
