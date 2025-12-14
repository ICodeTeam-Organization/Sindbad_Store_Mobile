import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../domain/repos/add_and_edit_product_store_repo.dart';
import '../data_source/add_and_edit_product_to_store_remote_data_source.dart';

class AddAndEditProductStoreRepoImpl extends AddAndEditProductStoreRepo {
  final AddProductToStoreRemoteDataSourceImpl
      addAndEditProductToStoreRemoteDataSource;

  AddAndEditProductStoreRepoImpl(this.addAndEditProductToStoreRemoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getMainAndSubCategory(
      String? updatedAt) async {
    try {
      var data = await addAndEditProductToStoreRemoteDataSource
          .getMainAndSubCategory(updatedAt: updatedAt);
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
  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
  }) async {
    try {
      List<BrandEntity> data = await addAndEditProductToStoreRemoteDataSource
          .getBrandsByMainCategoryId(
        mainCategoryId: mainCategoryId,
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
