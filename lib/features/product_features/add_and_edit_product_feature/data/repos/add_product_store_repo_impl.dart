import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/repos/add_and_edit_product_store_repo.dart';
import '../data_source/add_and_edit_product_to_store_remote_data_source.dart';

class AddAndEditProductStoreRepoImpl extends AddAndEditProductStoreRepo {
  final AddAndEditProductToStoreRemoteDataSource
      addAndEditProductToStoreRemoteDataSource;

  AddAndEditProductStoreRepoImpl(
      {required this.addAndEditProductToStoreRemoteDataSource});
  // Generic PostData function
  Future<Either<Failure, T>> postOneData<T>(
      Future<T> Function() postDataFunction) async {
    try {
      var dataPosted = await postDataFunction();
      print("==============  in add product impl  =============");
      print("==============  right => $dataPosted  =============");
      print("==============  in add product impl  =============");
      return right(dataPosted);
    } catch (e) {
      print("==============  in add product impl  =============");
      print("==============  catch => $e  =============");
      print("==============  in add product impl  =============");
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AddProductEntity>> addProductToStore(
      {required String name,
      required num price,
      required String description,
      required File mainImageFile,
      required String number,
      required int? storeId,
      required int? offerId,
      required int? brandId,
      required int mainCategoryId,
      required List<File> images,
      required List<int> subCategoryIds,
      required List<Map<String, String>> newAttributes}) async {
    return postOneData(
        () => addAndEditProductToStoreRemoteDataSource.addProductToStore(
              name: name,
              price: price,
              description: description,
              mainImageFile: mainImageFile,
              number: number,
              storeId: storeId,
              offerId: offerId,
              brandId: brandId,
              mainCategoryId: mainCategoryId,
              images: images,
              subCategoryIds: subCategoryIds,
              newAttributes: newAttributes,
            ));
  }

  @override
  Future<Either<Failure, List<MainCategoryEntity>>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    try {
      var data =
          await addAndEditProductToStoreRemoteDataSource.getMainAndSubCategory(
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

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      {required int productId}) async {
    try {
      ProductDetailsEntity data = await addAndEditProductToStoreRemoteDataSource
          .getProductDetails(productId: productId);
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
  Future<Either<Failure, EditProductEntity>> editProductFromStore(
      {required int id,
      required String description,
      required num price,
      required File mainImageFile,
      required int? storeId,
      required int? offerId,
      required int? brandId,
      required int mainCategoryId,
      required List<File> images,
      required List<int> subCategoryIds,
      required List<Map<String, String>> newAttributes}) {
    // TODO: implement editProductFromStore
    throw UnimplementedError();
  }
}
