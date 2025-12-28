import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/services/api_service.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/add_offer_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_data_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_products_model.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/update_offer_model.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';

abstract class NewOfferRemotDataSource {
  Future<List<OfferProductsEntity>> getOfferProducts(
    int pageSize,
    int pageNumber,
  );
  Future<AddOfferEntity> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<Map<String, dynamic>>? listProduct,
  );
  Future<UpdateOfferEntity> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  );
  Future<OfferDataEntity> getOfferData(
    int offerHeadId,
  );
}

class NewOfferRemotDataSourceImpl extends NewOfferRemotDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  NewOfferRemotDataSourceImpl(this.apiService, this.secureStorage);

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
      // If data['data'] is not a list, add the message to the list
      entities.add(fromJson(data));
    }

    return entities;
  }

  List<T> getItemsFromData<T>(
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

  // get OfferProductsEntity List function-------------------------------------------------
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

  // get AddOfferEntity a function-------------------------------------------------
  @override
  Future<AddOfferEntity> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<Map<String, dynamic>>? listProduct,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "name": offerTitle,
          "description": "",
          "startDate": startOffer.toIso8601String(),
          "endDate": endOffer.toIso8601String(),
          "isActive": true,
          "numberOfOrders": countProducts,
          "offerHeadType": typeName,
          "offerHeadOffers": listProduct,
        },
        endPoint: "Offers/Store/AddOffer",
        headers: {'Authorization': 'BEARER $token'});
    AddOfferEntity response = AddOfferModel.fromJson(data);
    return response;
  }

  // get AddOfferEntity a function-------------------------------------------------
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
          // "id": offerHeadId
        },
        endPoint: "Offers/Store/EditOffer/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    UpdateOfferEntity response = UpdateOfferModel.fromJson(data);
    return response;
  }

  // get OfferDataEntity for update a function-------------------------------------------------
  @override
  Future<OfferDataEntity> getOfferData(
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {},
        endPoint: "Offers/Store/GetOfferForEdit/$offerHeadId",
        headers: {'Authorization': 'BEARER $token'});
    OfferDataEntity response = OfferDataModel.fromJson(data.values.last);
    return response;
  }
}
