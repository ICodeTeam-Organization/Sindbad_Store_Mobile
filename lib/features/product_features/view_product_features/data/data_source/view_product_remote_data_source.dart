import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';

import '../../../../../core/api_service.dart';
import '../../domain/entities/activate_products_entity.dart';
import '../../domain/entities/disable_products_entity.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/activate_products_model/activate_products_model.dart';
import '../models/delete_product_model.dart';
import '../models/disable_products_model/disable_products_model.dart';
import '../models/main_category_for_view_model/item.dart';
import '../models/product_model/product_model.dart';
// import '../models/product_model/product_model.dart';

abstract class ViewProductRemoteDataSource {
  // for get MainCategory
  Future<List<MainCategoryForViewEntity>> getMainCategoryForView({
    required int pageNumper,
    required int pageSize,
  });

  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    required int? categoryId,
  });
  Future<DeleteProductEntity> deleteProductById({
    required int productId,
  });

  // for disable Products By [Ids]
  Future<DisableProductsEntity> disableProductsByIds({required List<int> ids});

  // for ActivateProducts By [Ids]
  Future<ActivateProductsEntity> activateProductsByIds(
      {required List<int> ids});
}

class ViewProductRemoteDataSourceImpl extends ViewProductRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage flutterSecureStorage;

  ViewProductRemoteDataSourceImpl(this.apiService, this.flutterSecureStorage);

  Future<String?> getToken() async {
    return await flutterSecureStorage.read(key: 'token');
  }

  // =====================  for Main Category For View  ======================
  @override
  Future<List<MainCategoryForViewEntity>> getMainCategoryForView(
      {required int pageNumper, required int pageSize}) async {
    final Map<String, dynamic> data = await apiService.get(
        endPoint:
            "Categories/GetCategories?searchType=1&isBrief=true&pageNumber=$pageNumper&pageSize=$pageSize");

    // fun for change Data from JSON to DartModel
    List<MainCategoryForViewEntity> changeToDartModel(List<dynamic> data) {
      List<MainCategoryForViewEntity> mainCategoryForViewEntity = data
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
      return mainCategoryForViewEntity;
    }

    List<MainCategoryForViewEntity> mainCategoryForView =
        changeToDartModel(data['data']['items'] as List<dynamic>);
    return mainCategoryForView;
  }

  // Generic function to convert data to a list of items entities
  List<T> getListProductsByfilter<T>(
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
    debugPrint('this the list added in data source $entities');

    return entities;
  }

  // get MyOrder List function
  List<ProductEntity> getAllProductsByfilter(Map<String, dynamic> data) {
    return getListProductsByfilter(data, (item) => ProductModel.fromJson(item));
  }

  @override
  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    required int? categoryId,
  }) async {
    String? token = await getToken();
    final Map<String, dynamic> requestData;
    switch (storeProductsFilter) {
      case 0: // for all products
        requestData = {
          "categoryId":
              categoryId, // if categoryId = null  will return all products
          "pageNumber": pageNumper,
          "pageSize": pageSize
        };
        break;
      case 1: // for products hasOffer
        requestData = {
          "hasOffer": true,
          "categoryId":
              categoryId, // if categoryId = null  will return all products offers
          "pageNumber": pageNumper,
          "pageSize": pageSize
        };
        break;
      case 2: // for products isDeleted
        requestData = {
          "isDisable": true,
          "categoryId":
              categoryId, // if categoryId = null  will return all products offers
          "pageNumber": pageNumper,
          "pageSize": pageSize
        };
        break;
      default:
        throw Exception("Invalid storeProductsFilter value");
    }
    var data = await apiService.post(
        endPoint: "Products/GetProductsWitheFilter?returnDtoName=1",
        data: requestData,
        headers: {"Authorization": "BEARER $token"});
    List<ProductEntity> products = getAllProductsByfilter(data);
    return products;
  }

  // fun Delete product by ID
  @override
  Future<DeleteProductEntity> deleteProductById(
      {required int productId}) async {
    String? token = await getToken();
    var data = await apiService.delete(
      endPoint: "Products/DeleteProduct?id=$productId",
      headers: {"Authorization": "BEARER $token"},
    );
    DeleteProductEntity responseDeleteProduct =
        DeleteProductModel.fromJson(data);
    print(
        " ===================== Bagar Message Delete Product =============== ");
    print(
        "========== Success =>  ${responseDeleteProduct.isSuuccess.toString()}");
    print("========== Message =>  ${responseDeleteProduct.message}");
    print(" ===================== Bagar =============== ");
    return responseDeleteProduct;
  }

  @override
  Future<DisableProductsEntity> disableProductsByIds(
      {required List<int> ids}) async {
    String? token = await getToken();
    var response = await apiService.patchForDisableOrActivateProductsOnly(
      endPoint: "Products/DisableProducts",
      data: ids,
      headers: {"Authorization": "BEARER $token"},
    );
    DisableProductsEntity responseDisableProducts =
        DisableProductsModel.fromJson(response);
    print(
        " ===================== Bagar Message Disable Product =============== ");
    print(
        "========== Success =>  ${responseDisableProducts.success.toString()}");
    print("========== Message =>  ${responseDisableProducts.message}");
    print(" ===================== Bagar =============== ");
    return responseDisableProducts;
  }

  // for ActivateProducts By [Ids]
  @override
  Future<ActivateProductsEntity> activateProductsByIds(
      {required List<int> ids}) async {
    String? token = await getToken();
    var response = await apiService.patchForDisableOrActivateProductsOnly(
      endPoint: "Products/ActivateProducts",
      data: ids,
      headers: {"Authorization": "BEARER $token"},
    );
    ActivateProductsEntity responseActivateProducts =
        ActivateProductsModel.fromJson(response);
    print(
        " ===================== Bagar Message Activate Product =============== ");
    print(
        "========== Success =>  ${responseActivateProducts.success.toString()}");
    print("========== Message =>  ${responseActivateProducts.message}");
    print(" ===================== Bagar =============== ");
    return responseActivateProducts;
  }
}
