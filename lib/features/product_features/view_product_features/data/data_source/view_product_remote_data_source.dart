import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';

import '../../../../../core/api_service.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/delete_product_model.dart';
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
    //
    required bool hasOffer,
    required bool isDeleted,
    //
  });
  Future<DeleteProductEntity> deleteProductById({
    required int productId,
  });
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
  // Future<List<ProductEntity>> getProductsByFilter(
  //     int storeProductsFilter, int pageNumper, int pageSize) async {
  //   var data = await apiService.get(
  //       endPoint: "Products/Store/GetStoreProductsWitheFilter");
  //   List<ProductEntity> products = getProductList(data);
  //   // print(products);
  //   return products;
  // }
  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
    //
    required bool hasOffer,
    required bool isDeleted,
    //
  }) async {
    String? token = await getToken();
    var data = await apiService.post(
        endPoint: "Products/GetProductsWitheFilter?returnDtoName=1",
        data: storeProductsFilter == 0
            ? {"pageNumber": pageNumper, "pageSize": pageSize}
            : {
                "hasOffer": hasOffer,
                "isDeleted": isDeleted,
                "categoryId": 0,
                // "storeId": "string",
                // "productName": "string",
                // "minPrice": 0,
                // "maxPrice": 0,
                "pageNumber": pageNumper,
                "pageSize": pageSize
              }
        //     data: {
        //   // "storeProductsFilter": storeProductsFilter,
        //   "pageNumber": pageNumper,
        //   "pageSize": pageSize,
        //   "offerId": null,
        //   "hasOffer": null,
        //   "categoryId": null,
        //   "storeId": null,
        //   "productName": null
        // }
        ,
        headers: {"Authorization": "BEARER $token"});
    List<ProductEntity> products = getAllProductsByfilter(data);
    print(" ===================== Bagar =============== ");
    print(products[0].productImageUrl);
    print(" ===================== Bagar =============== ");
    return products;
  }

  // fun Delete product by ID
  DeleteProductModel? deleteProductModel;
  @override
  Future<DeleteProductEntity> deleteProductById(
      {required int productId}) async {
    String? token = await getToken();
    var data = await apiService.delete(
        endPoint: "Products/DeleteProduct?id=$productId",
        headers: {"Authorization": "BEARER $token"});
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
}
