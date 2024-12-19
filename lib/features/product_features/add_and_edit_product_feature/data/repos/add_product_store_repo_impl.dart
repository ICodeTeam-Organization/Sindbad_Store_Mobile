import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/brand_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/main_category_entity.dart';
import '../../domain/repos/add_product_store_repo.dart';
import '../data_source/add_product_to_store_remote_data_source.dart';

class AddProductStoreRepoImpl extends AddProductStoreRepo {
  final AddProductToStoreRemoteDataSource addProductToStoreRemoteDataSource;

  AddProductStoreRepoImpl({required this.addProductToStoreRemoteDataSource});

  @override
  Future<Either<Failure, List<MainCategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    try {
      var data = await addProductToStoreRemoteDataSource.getMainAndSubCategory(
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

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrandsByMainCategoryId({
    required int mainCategoryId,
  }) async {
    try {
      List<BrandEntity> data =
          await addProductToStoreRemoteDataSource.getBrandsByMainCategoryId(
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
