import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/products_endpoint_parameters.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/product_remote_datasource.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';
import '../../../../../core/api_service.dart';
import '../../domain/entities/disable_products_entity.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../models/delete_product_model.dart';
import '../models/disable_products_model/disable_products_model.dart';
import '../models/main_category_for_view_model/item.dart';
import '../models/product_model/product_model.dart';

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
  Future<DeleteProductEntity> deleteProductById(
      {required int productId}) async {
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
}
