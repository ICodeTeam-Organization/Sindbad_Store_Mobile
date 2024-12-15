import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sindbad_management_app/core/errors/failure.dart';

import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/main_category_entity.dart';

import '../../domain/repos/add_product_store_repo.dart';
import '../data_source/main_and_sub_category_remote_data_source.dart';

class AddProductStoreRepoImpl extends AddProductStoreRepo {
  final MainAndSubCategoryRemoteDataSource mainAndSubCategoryRemoteDataSource;

  AddProductStoreRepoImpl({required this.mainAndSubCategoryRemoteDataSource});

  @override
  Future<Either<Failure, List<MainCategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    try {
      var data = await mainAndSubCategoryRemoteDataSource.getMainAndSubCategory(
        filterType: filterType,
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
}
