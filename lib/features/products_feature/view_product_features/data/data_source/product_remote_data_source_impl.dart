import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/products_endpoint_parameters.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/product_remote_datasource.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';
import '../../../../../core/services/api_service.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/delete_product_model.dart';
import '../models/main_category_for_view_model/item.dart';
import '../models/product_model/product_model.dart';
// Add/Edit Product imports
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/add_product_model.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/edit_product_model.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/product_details_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/brand_model/datum.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/category_model/data.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/data/models/product_details_model/product_details_model.dart';

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage flutterSecureStorage;

  ProductRemoteDataSourceImpl(this.apiService, this.flutterSecureStorage);

  Future<String?> getToken() async {
    return await flutterSecureStorage.read(key: 'token');
  }

  Future<String?> extractStoreIdFromToken() async {
    // Read the token
    final token = await flutterSecureStorage.read(key: 'token');
    if (token == null || token.isEmpty) {
      throw Exception("No token found in secure storage");
    }

    // Decode the token
    final decodedToken = JwtDecoder.decode(token);

    // Check for storeId or Id key
    final storeId = decodedToken["storeId"] ?? decodedToken["Id"];
    if (storeId == null) {
      throw Exception("Token does not contain a store ID");
    }

    // Convert to string (JWT fields may not always be strings)
    return storeId.toString();
  }

  // =====================  for Main Category For View  ======================
  @override
  Future<List<MainCategoryForViewEntity>> getMainCategoryForView(
      {required int pageNumber, required int pageSize}) async {
    String? token = await getToken();
    if (token == null || token.isEmpty) {
      throw Exception('No auth token available for getMainCategoryForView');
    }

    // Prefer standard 'Bearer' scheme (some servers may be case-sensitive)
    final headers = {"Authorization": "Bearer $token"};

    final Map<String, dynamic> data = await apiService.get(
        endPoint:
            // "Categories/GetCategories?searchType=1&isBrief=true&pageNumber=$pageNumber&pageSize=$pageSize");
            //   "Category?type=1&isBrief=true&pageNumber=$pageNumber&pageSize=$pageSize",
            "api/Categories",
        headers: headers);

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
  List<T> getListProductsByFilter<T>(
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
  List<ProductEntity> getAllProductsByFilter(Map<String, dynamic> data) {
    return getListProductsByFilter(data, (item) => ProductModel.fromJson(item));
  }

  @override
  Future<List<ProductEntity>> getProductsByFilter({
    required int storeProductsFilter,
    required int pageNumber,
    required int pageSize,
    required List<int>? categoryId,
  }) async {
    //String? token = await getToken();
    String? storeId = await extractStoreIdFromToken();

    // Handle categories properly - only include if categoryId is not null
    // final List<int>? categories = categoryId != null ? [categoryId] : null;
    final Map<String, dynamic> requestData;
    switch (storeProductsFilter) {
      case 0: // for all products
        requestData = ProductsEndpointParameters.buildQueryParameters(
          store: storeId,
          pageNumber: pageNumber,
          pageSize: pageSize,
          //  categories: categories
        );
        break;
      case 1: // for products hasOffer
        requestData = ProductsEndpointParameters.buildQueryParameters(
          hasOffer: true,
          store: storeId,
          pageNumber: pageNumber,
          pageSize: pageSize,
          //   categories: categories
        );
        break;
      case 2: // for products isDeleted
        requestData = ProductsEndpointParameters.buildQueryParameters(
          isActive: false,
          store: storeId,
          pageNumber: pageNumber,
          pageSize: pageSize,
          // categories: categories
        );
        break;
      default:
        throw Exception("Invalid storeProductsFilter value");
    }
    // Add common query parameters
    // Map<String, dynamic> query1 = ProductsEndpointParameters.buildQueryParameters();
    var data = await apiService.get(
      endPoint: "Products",
      queryParameters: requestData,
    );
    List<ProductEntity> products = getAllProductsByFilter(data);
    return products;
  }

  // fun Delete product by ID
  @override
  Future<DeleteProductEntity> deleteProductById(int productId) async {
    String? token = await getToken();
    var data = await apiService.delete(
      endPoint: "Products/DeleteProduct?id=$productId",
      headers: {"Authorization": "BEARER $token"},
    );
    DeleteProductEntity responseDeleteProduct =
        DeleteProductModel.fromJson(data);
    return responseDeleteProduct;
  }

  @override
  Future<bool> disableProductsByIds(List<int> ids) async {
    try {
      if (ids.isEmpty) {
        throw ArgumentError('Product IDs list cannot be empty');
      }

      final String? token = await getToken();

      if (token == null || token.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Authentication token is missing or invalid',
        );
      }

      final dio = Dio();
      final response = await dio.patch(
        'https://www.sindibad-back.com:82/api/Products/DisableProducts',
        data: ids,
        options: Options(
          headers: {
            "Authorization": "BEARER $token",
            "Content-Type": "application/json",
            "accept": "text/plain",
          },
        ),
      );

      print(response.data);

      final responseData = response.data;

      if (responseData['success'] == true) {
        return true;
      } else {
        final errorMessage = responseData['error'] ??
            responseData['message'] ??
            'Failed to disable products';

        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: errorMessage,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request timeout. Please try again.',
            type: e.type,
          );
        case DioExceptionType.badCertificate:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'SSL certificate error. Please check your connection.',
            type: e.type,
          );
        case DioExceptionType.badResponse:
          // Extract error from response if available
          final errorData = e.response?.data;
          final errorMessage = errorData is Map
              ? errorData['error'] ??
                  errorData['message'] ??
                  e.error?.toString() ??
                  'Server error occurred'
              : e.error?.toString() ?? 'Server error occurred';

          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: errorMessage,
            type: e.type,
          );
        case DioExceptionType.cancel:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request was cancelled',
            type: e.type,
          );
        case DioExceptionType.connectionError:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'No internet connection. Please check your network.',
            type: e.type,
          );
        case DioExceptionType.unknown:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Network error: ${e.error}',
            type: e.type,
          );
      }
    } catch (e) {
      // Handle non-Dio exceptions
      if (e is ArgumentError) {
        rethrow; // Re-throw argument errors as-is
      }

      // Wrap other non-Dio exceptions in DioException
      throw DioException(
        requestOptions: RequestOptions(path: 'Products/DisableProducts'),
        error: 'Failed to disable products: $e',
        type: DioExceptionType.unknown,
      );
    }
  }

  // for ActivateProducts By [Ids]
  @override
  Future<bool> activateProductsByIds(List<int> ids) async {
    try {
      if (ids.isEmpty) {
        throw ArgumentError('Product IDs list cannot be empty');
      }

      final String? token = await getToken();

      if (token == null || token.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Authentication token is missing or invalid',
        );
      }

      final dio = Dio();
      final response = await dio.patch(
        'https://www.sindibad-back.com:82/api/Products/ActivateProducts',
        data: ids,
        options: Options(
          headers: {
            "Authorization": "BEARER $token",
            "Content-Type": "application/json",
            "accept": "text/plain",
          },
        ),
      );

      print(response.data);

      final responseData = response.data;

      if (responseData['success'] == true) {
        return true;
      } else {
        final errorMessage = responseData['error'] ??
            responseData['message'] ??
            'Failed to activate products';

        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: errorMessage,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request timeout. Please try again.',
            type: e.type,
          );
        case DioExceptionType.badCertificate:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'SSL certificate error. Please check your connection.',
            type: e.type,
          );
        case DioExceptionType.badResponse:
          final errorData = e.response?.data;
          final errorMessage = errorData is Map
              ? errorData['error'] ??
                  errorData['message'] ??
                  e.error?.toString() ??
                  'Server error occurred'
              : e.error?.toString() ?? 'Server error occurred';

          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: errorMessage,
            type: e.type,
          );
        case DioExceptionType.cancel:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request was cancelled',
            type: e.type,
          );
        case DioExceptionType.connectionError:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'No internet connection. Please check your network.',
            type: e.type,
          );
        case DioExceptionType.unknown:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Network error: ${e.error}',
            type: e.type,
          );
      }
    } catch (e) {
      if (e is ArgumentError) {
        rethrow;
      }

      throw DioException(
        requestOptions: RequestOptions(path: 'Products/ActivateProducts'),
        error: 'Failed to activate products: $e',
        type: DioExceptionType.unknown,
      );
    }
  }

  @override
  Future<List<ProductEntity>> getAllProducts(
      int pageNumber, int pageSize, List<int>? categoryId) async {
    try {
      final response = await apiService.get(
        endPoint: "Products?pageNumber=$pageNumber&pageSize=$pageSize",
      );

      // Handle backend-level errors: success = false
      if (response.containsKey('success') && response['success'] == false) {
        throw DioException(
          requestOptions: RequestOptions(path: "Products"),
          message: response['message'] ?? "Backend returned an error",
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: RequestOptions(path: "Products"),
            data: response,
            statusCode: 400,
          ),
        );
      }

      final items = response['data']?['items'];
      if (items == null || items is! List) {
        throw DioException(
          requestOptions: RequestOptions(path: "Products"),
          message: "Invalid JSON: items missing or not a list",
          type: DioExceptionType.badResponse,
        );
      }

      return items.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException {
      rethrow; // Pass Dio errors up the chain without wrapping
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: "Products"),
        message: "Unexpected error: $e",
        type: DioExceptionType.unknown,
      );
    }
  }

  // ==================== Add/Edit Product Methods ====================

  Future<void> saveRequest() async {
    return await flutterSecureStorage.write(
        key: 'updatedAt', value: DateTime.now().toUtc().toString());
  }

  @override
  Future<AddProductEntity> addProductToStore({
    required String name,
    required num price,
    required String description,
    required File mainImageFile,
    required String number,
    required int mainCategoryId,
    required List<int> subCategoryIds,
    int? storeId,
    int? offerId,
    int? brandId,
    List<File>? images,
    List<Map<String, String>>? newAttributes,
    List<String>? tags,
    num? oldPrice,
    String? shortDescription,
    String? token,
  }) async {
    try {
      // Validate required arguments (only truly required ones)
      if (name.isEmpty) {
        throw ArgumentError('Product name cannot be empty');
      }
      if (!mainImageFile.existsSync()) {
        throw ArgumentError('Main image file does not exist');
      }

      // Use provided token or get from storage
      final String? authToken = token ?? await getToken();
      if (authToken == null || authToken.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Authentication token is missing or invalid',
        );
      }

      // Prepare FormData for multipart file upload - matching successful curl request format
      final formData = FormData.fromMap({
        "Name": name,
        "Price": price,
        "Number": number,
        "MainCategoryId": mainCategoryId,
        "MainImage": await MultipartFile.fromFile(
          mainImageFile.path,
          filename: mainImageFile.path.split('/').last,
        ),
        // Optional fields - only include if they have values
        if (description.isNotEmpty) "Description": description,
        if (storeId != null) "StoreId": storeId,
        if (offerId != null) "OfferId": offerId,
        if (oldPrice != null && oldPrice > 0) "OldPrice": oldPrice,
        if (shortDescription != null && shortDescription.isNotEmpty)
          "ProductDetails": shortDescription,
        if (brandId != null && brandId != 0) "BrandId": brandId,
      });

      // Add additional images if any
      if (images != null) {
        for (int i = 0; i < images.length; i++) {
          formData.files.add(MapEntry(
            'Images',
            await MultipartFile.fromFile(
              images[i].path,
              filename: images[i].path.split('/').last,
            ),
          ));
        }
      }

      final dio = Dio();
      final response = await dio.post(
        'https://www.sindibad-back.com:82/api/Products/AddProduct',
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $authToken",
            "accept": "text/plain",
          },
        ),
      );

      final responseData = response.data;

      if (responseData['success'] == true) {
        AddProductEntity body = AddProductModel.fromJson(responseData);
        return body;
      } else {
        final errorMessage = responseData['error'] ??
            responseData['message'] ??
            'Failed to add product';

        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: errorMessage,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      // Handle Dio-specific exceptions
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request timeout. Please try again.',
            type: e.type,
          );
        case DioExceptionType.badCertificate:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'SSL certificate error. Please check your connection.',
            type: e.type,
          );
        case DioExceptionType.badResponse:
          print(e.response?.data);
          // Extract error from response if available
          final errorData = e.response?.data;
          final errorMessage = errorData is Map
              ? errorData['error'] ??
                  errorData['message'] ??
                  e.error?.toString() ??
                  'Server error occurred'
              : e.error?.toString() ?? 'Server error occurred';

          throw DioException(
            requestOptions: e.requestOptions,
            response: e.response,
            error: errorMessage,
            type: e.type,
          );
        case DioExceptionType.cancel:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Request was cancelled',
            type: e.type,
          );
        case DioExceptionType.connectionError:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'No internet connection. Please check your network.',
            type: e.type,
          );
        case DioExceptionType.unknown:
          throw DioException(
            requestOptions: e.requestOptions,
            error: 'Network error: ${e.error}',
            type: e.type,
          );
      }
    } catch (e) {
      // Handle non-Dio exceptions
      if (e is ArgumentError) {
        rethrow; // Re-throw argument errors as-is
      }

      // Wrap other non-Dio exceptions in DioException
      throw DioException(
        requestOptions: RequestOptions(path: 'Products/AddProduct'),
        error: 'Failed to add product: $e',
        type: DioExceptionType.unknown,
      );
    }
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
      "StoreId": storeId,
      "BrandId": brandId,
      "MainCategoryId": mainCategoryId,
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

  List<T> getListFromPagedResult<T>(
      Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    List<T> entities = [];

    if (data['data']['items'] is List) {
      for (var item in data['data']['items']) {
        entities.add(fromJson(item));
      }
    } else if (data['message'] != null) {
      entities.add(fromJson(data));
    }

    return entities;
  }

  List<CategoryEntity> getCategorylist(Map<String, dynamic> data) {
    return getListFromPagedResult(
        data, (item) => CategoryModels.fromJson(item));
  }

  @override
  Future<List<CategoryEntity>> getMainAndSubCategory(
      {String? updatedAt}) async {
    String? token = await getToken();
    final Map<String, dynamic> data;
    if (updatedAt == null) {
      data = await apiService.get(
          endPoint: "Categories?types=1&level=1&level=2",
          headers: {'Authorization': 'Bearer $token'});
    } else {
      data = await apiService.get(
          endPoint: "Categories?types=1&level=1&level=2&updatedAt=$updatedAt",
          headers: {'Authorization': 'Bearer $token'});
      print(data);
    }
    saveRequest();

    List<CategoryEntity> mainAndSubCategories = getCategorylist(data);

    return mainAndSubCategories;
  }

  @override
  Future<List<BrandEntity>> getBrandsByMainCategoryId({
    required int? mainCategoryId,
  }) async {
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
  }

  @override
  Future<ProductDetailsEntity> getProductDetails({
    required int productId,
  }) async {
    String? token = await getToken();
    final Map<String, dynamic> data = await apiService.get(
        endPoint: "Products/GetProductDetails/$productId",
        headers: {'Authorization': 'Bearer $token'});

    ProductDetailsEntity productDetailsEntity =
        ProductDetailsModel.fromJson(data["data"]);
    return productDetailsEntity;
  }
}
