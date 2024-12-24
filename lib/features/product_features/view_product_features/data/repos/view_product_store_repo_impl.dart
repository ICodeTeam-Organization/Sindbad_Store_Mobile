import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';

import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/product_entity.dart';

import '../../domain/repos/view_product_store_repo.dart';
import '../data_source/view_product_remote_data_source.dart';

class ViewProductStoreRepoImpl extends ViewProductRepo {
  final ViewProductRemoteDataSource viewProductRemoteDataSource;

  ViewProductStoreRepoImpl({required this.viewProductRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    //
    required bool hasOffer,
    required bool isDeleted,
    //
  }) async {
    try {
      var data = await viewProductRemoteDataSource.getProductsByFilter(
          storeProductsFilter: storeProductsFilter,
          pageNumper: pageNumper,
          pageSize: pageSize,
          //
          hasOffer: hasOffer,
          isDeleted: isDeleted
          //
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
    } finally {
      // to control errMessage when response 404 becouse we can
      return left(ServerFailure("المنتج غير موجود."));
    }
  }
}
