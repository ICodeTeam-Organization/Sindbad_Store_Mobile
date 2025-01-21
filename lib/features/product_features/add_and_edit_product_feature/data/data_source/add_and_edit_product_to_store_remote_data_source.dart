import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/models/add_product_model.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/models/edit_product_model.dart';
import '../../domain/entities/add_product_entities/add_product_entity.dart';
import '../../domain/entities/add_product_entities/brand_entity.dart';
import '../../domain/entities/add_product_entities/main_category_entity.dart';
import '../../domain/entities/edit_product_entities/edit_product_entity.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../models/brand_model/datum.dart';
import '../models/main_and_sub_category_model/item.dart';
import '../models/product_details_model/product_details_model.dart';

abstract class AddAndEditProductToStoreRemoteDataSource {
  Future<AddProductEntity> addProductToStore({
    required String name,
    required num price,
    required String description,
    required File mainImageFile,
    required String number,
    // i don't know what data tybe and value
    required int? storeId,
    required int? offerId,
    required int? brandId,
    //
    required int mainCategoryId,
    required List<File> images,
    required List<int> subCategoryIds,
    // required List<Map<String, String>> newAttributes,
    required List<Map<String, String>> newAttributes,
  });
  Future<EditProductEntity> editProductFromStore({
    required int id,
    // required String name,
    required num price,
    required String description,
    required File? mainImageFile,
    // required String number,
    required int? storeId,
    required int? offerId,
    required int? brandId,
    required int mainCategoryId,
    required List<File>? images,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
  });

  Future<List<MainCategoryEntity>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  });
  Future<List<BrandEntity>> getBrandsByMainCategoryId({
    required int mainCategoryId,
  });
  Future<ProductDetailsEntity> getProductDetails({
    required int productId,
  });
}

class AddProductToStoreRemoteDataSourceImpl
    extends AddAndEditProductToStoreRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  AddProductToStoreRemoteDataSourceImpl(this.apiService, this.secureStorage);

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  @override
  Future<AddProductEntity> addProductToStore({
    required String name,
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
    // required List<Map<String, String>> newAttributes,
    required List<Map<String, String>> newAttributes,
  }) async {
    String? token = await getToken();
    final Map<String, dynamic> dataBody = {
      "Name": name,
      "Price": price,
      "Description": description,
      // "MainImageUrl": mainImageFile,   // down.. in with files
      "Number": number,
      "StoreId": storeId,
      "OfferId": offerId,
      "BrandId": brandId,
      "MainCategoryId": mainCategoryId,
      // "Images": images,                // down.. in with files
      "SubCategoryIds": subCategoryIds,
      "newAttributes": newAttributes
    };
    final data = await apiService.postRequestWithFiles(
      endPoint: "Products/AddProduct",
      data: dataBody,
      pdfFile: mainImageFile, // ====> this not working <====== //
      file: mainImageFile,
      imageFiles: images,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    AddProductEntity body = AddProductModel.fromJson(data);

    return body;
  }

  // =========================  for get MainAndSubCategory  ===========================
  @override
  Future<List<MainCategoryEntity>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    final Map<String, dynamic> data = await apiService.get(
        endPoint:
            "Categories/GetCategoriesWithFilter?filterType=$filterType&pageSize=$pageSize&pageNumber=$pageNumper");

    // change Data from JSON to DartModel
    List<MainCategoryEntity> changeToDartModel(List<dynamic> data) {
      List<MainCategoryEntity> mainCategoryEntity = data
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
      return mainCategoryEntity;
    }

    List<MainCategoryEntity> mainAndSubCategores =
        changeToDartModel(data['data']['items'] as List<dynamic>);
    return mainAndSubCategores;
  }

  // =============================  for get Brands  ==================================
  @override
  Future<List<BrandEntity>> getBrandsByMainCategoryId(
      {required int mainCategoryId}) async {
    final Map<String, dynamic> data = await apiService.get(
        endPoint: "Brands/GetBrandsByMainCategory/$mainCategoryId");

    // fun change Data from JSON to DartModel
    List<BrandEntity> changeToDartModel(List<dynamic> data) {
      List<BrandEntity> brandsEntity = data
          .map((datum) => Datum.fromJson(datum as Map<String, dynamic>))
          .toList();
      return brandsEntity;
    }

    List<BrandEntity> brands = changeToDartModel(data['data'] as List<dynamic>);
    return brands;
  }

  // ============================  for get Product Details  ===========================
  @override
  Future<ProductDetailsEntity> getProductDetails(
      {required int productId}) async {
    final Map<String, dynamic> data =
        await apiService.get(endPoint: "Products/GetProductDetails/$productId");

    // change Data from JSON to DartModel
    ProductDetailsEntity productDetailsEntity =
        ProductDetailsModel.fromJson(data["data"]);
    return productDetailsEntity;
  }

  @override
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
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
  }) async {
    String? token = await getToken();
    final Map<String, dynamic> dataBody = {
      "Price": price,
      "Description": description,
      // "MainImageUrl": mainImageFile,   // down.. in with files
      "StoreId": storeId,
      "OfferId": offerId,
      "BrandId": brandId,
      "MainCategoryId": mainCategoryId,
      // "Images": images,                // down.. in with files
      "SubCategoryIds": subCategoryIds,
      "newAttributes": newAttributes
    };
    final data = await apiService.putWithFilesForEditProduct(
      endPoint: "Products/UpdateProduct?id=$id",
      data: dataBody,
      imageFile: mainImageFile,
      imageFiles: images,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    EditProductEntity body = EditProductModel.fromJson(data);

    return body;
  }
}
