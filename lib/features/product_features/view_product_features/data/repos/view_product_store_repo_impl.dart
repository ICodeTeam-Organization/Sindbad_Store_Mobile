import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sindbad_management_app/core/errors/failure.dart';

import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/product_entity.dart';

import '../../domain/repos/view_product_store_repo.dart';
import '../data_source/view_product_remote_data_source.dart';

class ViewProductStoreRepoImpl extends ViewProductRepo {
  final ViewProductRemoteDataSource viewProductRemoteDataSource;

  ViewProductStoreRepoImpl({required this.viewProductRemoteDataSource});
  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter(
      int storeProductsFilter, int pageNumper, int pageSize) async {
    try {
      var data = await viewProductRemoteDataSource.getProductsByFilter(
          storeProductsFilter, pageNumper, pageSize);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
