import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_details_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';

abstract class ViewOfferRemotDataSource {
  Future<List<OfferEntity>> getOffer(
    int pageSize,
    int pageNumber,
  );
  Future<List<OfferDetailsEntity>> getOfferDetails(
    int pageSize,
    int pageNumber,
    int offerHeadId,
  );
}

class ViewOfferRemotDataSourceImpl extends ViewOfferRemotDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  ViewOfferRemotDataSourceImpl(this.apiService, this.secureStorage);

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
    print('this the list added in data source $entities');

    return entities;
  }

  // get OfferEntity List function---------------------------------------------------------------
  List<OfferEntity> getOfferList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => OfferModel.fromJson(item));
  }

  @override
  Future<List<OfferEntity>> getOffer(int pageNumber, int pageSize) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {
        "pageSize": 10,
        "pageNumber": 1,
      },
      endPoint: 'Store/GetStoreOfferHeads',
      headers: {
        'Authorization': 'BEARER $token',
      },
    );
    List<OfferEntity> offer = getOfferList(data);
    print(offer);
    return offer;
  }

  // get OfferDetailsEntity List function-------------------------------------------------
  List<OfferDetailsEntity> getOfferDetailsList(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OfferDetailsModel.fromJson(item));
  }

  @override
  Future<List<OfferDetailsEntity>> getOfferDetails(
    int pageNumber,
    int pageSize,
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {
        "pageSize": 10,
        "pageNumber": 1,
        // "search": "string",
        // "type": "string",
        "offerHeadId": offerHeadId,
        // "isOfferHeadId": false
      },
      endPoint: 'Store/GetStoreOffers',
      headers: {
        'Authorization': 'BEARER $token',
      },
    );
    List<OfferDetailsEntity> orders = getOfferDetailsList(data);
    print(orders);
    return orders;
  }
}
