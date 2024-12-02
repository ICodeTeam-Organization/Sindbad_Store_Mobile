import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';

import '../../../../../core/api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../models/delete_product_model.dart';
import '../models/product_model/product_model.dart';
// import '../models/product_model/product_model.dart';

abstract class ViewProductRemoteDataSource {
  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumper,
    required int pageSize,
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
  Future<List<ProductEntity>> getProductsByFilter(
      {required int storeProductsFilter,
      required int pageNumper,
      required int pageSize}) async {
    String? token = await getToken();
    var data = await apiService
        .post(endPoint: "Products/Store/GetStoreProductsWitheFilter", data: {
      "storeProductsFilter": storeProductsFilter,
      "pageNumber": pageNumper,
      "pageSize": pageSize,
      "offerId": null,
      "hasOffer": null,
      "categoryId": null,
      "storeId": null,
      "productName": null
    }, headers: {
      "Authorization": "BEARER $token"
    });
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
    print(" ===================== Bagar =============== ");
    print(
        "========== Success =>  ${responseDeleteProduct.isSuuccess.toString()}");
    print("========== Message =>  ${responseDeleteProduct.message}");
    print(" ===================== Bagar =============== ");
    return responseDeleteProduct;
  }
}
