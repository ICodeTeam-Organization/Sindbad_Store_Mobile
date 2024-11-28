import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../core/api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model/product_model.dart';
// import '../models/product_model/product_model.dart';

abstract class ViewProductRemoteDataSource {
  Future<List<ProductEntity>> getProductsByFilter(
    int storeProductsFilter,
    int pageNumper,
    int pageSize,
  );
}

class ViewProductRemoteDataSourceImpl extends ViewProductRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage flutterSecureStorage;

  ViewProductRemoteDataSourceImpl(this.apiService, this.flutterSecureStorage);

  // // Generic function to convert data to a list of items entities
  // List<T> getListProductsByFiltireFromData<T>(
  //     Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) {
  //   List<T> entities = [];

  //   if (data['data']['items'] is List) {
  //     for (var item in data['data']['items']) {
  //       entities.add(fromJson(item));
  //     }
  //   } else if (data['message'] != null) {
  //     // If data['data'] is not a list, add the message to the list
  //     entities.add(fromJson(data));
  //   }
  //   print('this the list added in data source $entities');

  //   return entities;
  // }

  // // get MyOrder List function
  // List<ProductEntity> getListProductsByfilter(Map<String, dynamic> data) {
  //   return getListProductsByFiltireFromData(
  //       data, (item) => ProductModel.fromJson(item));
  // }

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
    print('this the list added in data source $entities');

    return entities;
  }

  // get MyOrder List function
  List<ProductEntity> getAllProductsByfilter(Map<String, dynamic> data) {
    return getListProductsByfilter(data, (item) => ProductModel.fromJson(item));
  }

  @override
  Future<List<ProductEntity>> getProductsByFilter(
      int storeProductsFilter, int pageNumper, int pageSize) async {
    String? token = await getToken();
    var data = await apiService
        .post(endPoint: "Products/Store/GetStoreProductsWitheFilter", data: {
      "storeProductsFilter": 1,
      "pageNumber": 1,
      "pageSize": 10,
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

  // List<ProductEntity> getProductList(Map<String, dynamic> data) {
  //   print(" ===================== hhhhhhh =============== ");
  //   print(data['data']['items']);
  //   print(" ===================== hhhhhhhhh =============== ");
  //   List<ProductEntity> products = [];
  //   for (var productMap in data['data']['items']) {
  //     products.add(Item.fromJson(productMap) as ProductEntity);
  //   }
  //   // print(" ===================== Bagar =============== ");
  //   // print(products);
  //   // print(" ===================== Bagar =============== ");
  //   return products;
  // }
  // List<ProductEntity> getProductList(Map<String, dynamic> data) {
  //   List<ProductEntity> products = [];

  //   if (data['data'] != null && data['data']['items'] != null) {
  //     for (var productMap in data['data']['items']) {
  //       // استخدم ProductModel لتحليل البيانات
  //       products.add(ProductModel.fromJson({
  //         'data': {
  //           'items': [productMap]
  //         }
  //       }));
  //     }
  //   }

  //   print(" ===================== Bagar =============== ");
  //   for (var product in products) {
  //     print('Product ID: ${product.productid}, Name: ${product.productName}');
  //   }
  //   print(" ===================== Bagar =============== ");
  //   return products;
  // }
}
