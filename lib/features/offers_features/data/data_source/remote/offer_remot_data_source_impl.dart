import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offers_features/data/data_source/remote/offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_data_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_details_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_products_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/post_response_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/update_offer_model.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';

class OfferRemotDataSourceImpl extends OfferRemotDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  OfferRemotDataSourceImpl(this.apiService, this.secureStorage);

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  // Generic function to convert data to a list of items entities
  List<T> getListItemsFromData<T>(
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

  // ============================================================
  // View Offer Operations
  // ============================================================

  List<OfferEntity> getOfferList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => OfferModel.fromJson(item));
  }

  @override
  Future<List<OfferEntity>> getOffer(int pageSize, int pageNumber) async {
    String? token = await getToken();
    var data = await apiService.get(
      endPoint:
          'Offers/Store/GetStoreOfferHeads?PageSize=100&PageNumber=$pageNumber',
      headers: {'Authorization': 'BEARER $token'},
    );
    List<OfferEntity> response = getOfferList(data);
    return response;
  }

  List<OfferDetailsEntity> getOfferDetailsList(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OfferDetailsModel.fromJson(item));
  }

  @override
  Future<List<OfferDetailsEntity>> getOfferDetails(
    int pageSize,
    int pageNumber,
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.get(
      endPoint: 'Offers/Store/GetStoreOffers?OfferHeadId=$offerHeadId',
      headers: {'Authorization': 'BEARER $token'},
    );
    List<OfferDetailsEntity> response = getOfferDetailsList(data);
    return response;
  }

  @override
  Future<PostResponseEntity> deleteOffer(int offerHeadId) async {
    String? token = await getToken();
    var data = await apiService.delete(
        endPoint: "Offers/Store/DeleteOffer/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    PostResponseEntity response = PostResponseModel.fromJson(data);
    return response;
  }

  @override
  Future<PostResponseEntity> changeStatusOffer(int offerHeadId) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {},
        endPoint: "Offers/Store/ActivateOffers/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    PostResponseEntity response = PostResponseModel.fromJson(data);
    return response;
  }

  // ============================================================
  // New/Edit Offer Operations
  // ============================================================

  List<OfferProductsEntity> getOfferProductsList(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OfferProductsModel.fromJson(item));
  }

  @override
  Future<List<OfferProductsEntity>> getOfferProducts(
    int pageSize,
    int pageNumber,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {
        "hasNoOffer": true,
        "hasOffer": false,
        "pageSize": 100,
        "pageNumber": pageNumber,
      },
      endPoint: 'Products/GetProductsWitheFilter?returnDtoName=1',
      headers: {'Authorization': 'BEARER $token'},
    );
    List<OfferProductsEntity> response = getOfferProductsList(data);
    return response;
  }

  @override
  Future<bool> addOffer({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int numberOfOrders,
    required int offerHeadType,
    required List<Map<String, dynamic>> offerHeadOffers,
  }) async {
    try {
      // Validate parameters
      if (name.isEmpty) {
        throw ArgumentError('Offer name cannot be empty');
      }

      if (offerHeadOffers.isEmpty) {
        throw ArgumentError('Offer products list cannot be empty');
      }

      // Check token
      final String? token = await getToken();

      if (token == null || token.isEmpty) {
        throw DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Authentication token is missing or invalid',
        );
      }

      final dio = Dio();
      final response = await dio.post(
        'https://www.sindibad-back.com:82/api/Offers/Store/AddOffer',
        data: {
          "name": name,
          "description": description,
          "startDate": startDate.toIso8601String(),
          "endDate": endDate.toIso8601String(),
          "isActive": isActive,
          "numberOfOrders": numberOfOrders,
          "offerHeadType": offerHeadType,
          "offerHeadOffers": offerHeadOffers,
        },
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
            'Failed to add offer';

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
        requestOptions: RequestOptions(path: 'Offers/Store/AddOffer'),
        error: 'Failed to add offer: $e',
        type: DioExceptionType.unknown,
      );
    }
  }

  @override
  Future<UpdateOfferEntity> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.put(
        data: {
          "name": offerTitle,
          "description": "",
          "startDate": startOffer.toIso8601String(),
          "endDate": endOffer.toIso8601String(),
          "isActive": true,
          "numberOfOrders": countProducts,
          "offerHeadType": typeName,
          "offerHeadOffers": listProduct,
          "justActiveAndDis": false,
        },
        endPoint: "Offers/Store/EditOffer/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    UpdateOfferEntity response = UpdateOfferModel.fromJson(data);
    return response;
  }

  @override
  Future<OfferDataEntity> getOfferData(int offerHeadId) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {},
        endPoint: "Offers/Store/GetOfferForEdit/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    OfferDataEntity response = OfferDataModel.fromJson(data.values.last);
    return response;
  }
}
