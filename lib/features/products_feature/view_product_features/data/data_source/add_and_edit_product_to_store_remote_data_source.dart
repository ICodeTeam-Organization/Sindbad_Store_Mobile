import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/add_product_model.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/edit_product_model.dart';
import '../../../add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';
import '../../../add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import '../../../add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';
import '../../../add_and_edit_product_feature/domain/entities/edit_product_entities/product_details_entity.dart';
import '../../../add_and_edit_product_feature/data/models/brand_model/datum.dart';
import '../../../add_and_edit_product_feature/data/models/category_model/data.dart';
import '../../../add_and_edit_product_feature/data/models/product_details_model/product_details_model.dart';

abstract class AddAndEditProductToStoreRemoteDataSource {
  Future<AddProductEntity> addProductToStore({
    required String name,
    required num price,
    required String description,
    required File mainImageFile,
    required String number,
    // i don't use it
    required int? storeId,
    required int? offerId,
    //
    required int? brandId,
    required int mainCategoryId,
    required List<File> images,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
    required List<String> tags,
    required num oldPrice,
    required String shortDescription,
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
    required List<String>? imagesUrl,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
    required num? oldPrice,
    required String? shortDescription,
    required List<String>? tags,
  });

  Future<List<CategoryEntity>> getMainAndSubCategory({String? updatedAt});
  Future<List<BrandEntity>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
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

  Future<void> saveRequest() async {
    return await secureStorage.write(
        key: 'updatedAt', value: DateTime.now().toUtc().toString());
  }

  @override
  Future<AddProductEntity> addProductToStore(
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
      required List<Map<String, String>> newAttributes,
      required List<String> tags,
      required num oldPrice,
      required String shortDescription,
      re}) async {
    String? token = await getToken();
    final Map<String, dynamic> dataBody = {
      "Name": name,
      "Price": price,
      "Description": description,
      // "MainImageUrl": mainImageFile,   // down.. in with files
      "Number": number,
      "StoreId": storeId,
      "OfferId": offerId,
      'Tags': tags,
      "OldPrice": oldPrice,
      "ProductDetails": shortDescription,
      // "BrandId": brandId,

      // this is for the case of brandId = 000 when the user select "لايوجد"
      // we make the brandId = 000 and send it as null else send the brandId
      "BrandId": brandId == 000 ? null : brandId,
      "MainCategoryId": mainCategoryId,
      // "Images": images,                // down.. in with files
      "SubCategoryIds": subCategoryIds,
      "newAttributes": newAttributes,
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

  List<T> getListFromPagedResult<T>(
      Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    List<T> entities = [];

    if (data['data']['items'] is List) {
      for (var item in data['data']['items']) {
        entities.add(fromJson(item));
      }
    } else if (data['message'] != null) {
      // If data['data'] is not a list, add the message to the list
      entities.add(fromJson(data));
    }

    return entities;
  }

  List<CategoryEntity> getCategorylist(Map<String, dynamic> data) {
    return getListFromPagedResult(
        data, (item) => CategoryModels.fromJson(item));
  }

  // =========================  for get MainAndSubCategory  ===========================
  @override
  Future<List<CategoryEntity>> getMainAndSubCategory(
      {String? updatedAt}) async {
    String? token = await getToken();
    final Map<String, dynamic> data;
    if (updatedAt == null) {
      data = await apiService.get(
          endPoint:
              // "Categories/GetCategoriesWithFilter?filterType=$filterType&pageSize=$pageSize&pageNumber=$pageNumber");
              "Categories?types=1&level=1&level=2",
          headers: {'Authorization': 'Bearer $token'});
    } else {
      data = await apiService.get(
          endPoint:
              // "Categories?types=1&level=1&level=2&updatedAt=2025-10-18%2007%3A48%3A14.768144",
              "Categories?types=1&level=1&level=2&updatedAt=$updatedAt",
          headers: {'Authorization': 'Bearer $token'});
      print(data);
    }
    // current sending request
    saveRequest();

    // change Data from JSON to DartModel
    List<CategoryEntity> mainAndSubCategories = getCategorylist(data);

    return mainAndSubCategories;
  }

  // =============================  for get Brands  ==================================
  @override
  Future<List<BrandEntity>> getBrandsByMainCategoryId(
      {required int? mainCategoryId}) async {
    String? token = await getToken();
    if (mainCategoryId == null) {
      final Map<String, dynamic> data = await apiService
          .get(endPoint: "Brands", headers: {'Authorization': 'Bearer $token'});
      List<BrandEntity> changeToDartModel(List<dynamic> data) {
        List<BrandEntity> brandsEntity = data
            .map((datum) => Datum.fromJson(datum as Map<String, dynamic>))
            .toList();
        return brandsEntity;
      }

      List<BrandEntity> brands =
          changeToDartModel(data['data'] as List<dynamic>);
      return brands;
    } else {
      final Map<String, dynamic> data = await apiService.get(
          endPoint: "Brands?categoryId=$mainCategoryId",
          headers: {'Authorization': 'Bearer $token'});
      List<BrandEntity> changeToDartModel(List<dynamic> data) {
        List<BrandEntity> brandsEntity = data
            .map((datum) => Datum.fromJson(datum as Map<String, dynamic>))
            .toList();
        return brandsEntity;
      }

      List<BrandEntity> brands =
          changeToDartModel(data['data'] as List<dynamic>);
      return brands;
    }

    // fun change Data from JSON to DartModel
  }

  // ============================  for get Product Details  ===========================
  @override
  Future<ProductDetailsEntity> getProductDetails(
      {required int productId}) async {
    String? token = await getToken();
    final Map<String, dynamic> data = await apiService.get(
        endPoint: "Products/GetProductDetails/$productId",
        headers: {'Authorization': 'Bearer $token'});

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
    required List<String>? imagesUrl,
    required List<int> subCategoryIds,
    required List<Map<String, String>> newAttributes,
    required num? oldPrice,
    required String? shortDescription,
    required List<String>? tags,
  }) async {
    String? token = await getToken();
    final Map<String, dynamic> dataBody = {
      "Price": price,
      "Description": description,
      // "MainImageUrl": mainImageFile,   // down.. in with files
      "StoreId": storeId,
      // "OfferId": offerId,
      "BrandId": brandId,
      "MainCategoryId": mainCategoryId,
      // "Images": images,                // down.. in with files
      "ImagesUrl": imagesUrl,
      "SubCategoryIds": subCategoryIds,
      "newAttributes": newAttributes,
      "OldPrice": oldPrice,
      "productDetails": shortDescription,
      "Tags": tags,
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
