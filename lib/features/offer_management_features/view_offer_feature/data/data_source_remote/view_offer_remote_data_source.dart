import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/change_status_offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/delete_offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_details_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/change_status_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/delete_offer_entity.dart';
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
  Future<DeleteOfferEntity> deleteOffer(
    int offerHeadId,
  );
  Future<ChangeStatusOfferEntity> changeStatusOffer(
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
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        // "search": "string",
        // "type": "string",
        // "offerHeadId": 0,
        // "isOfferHeadId": true
      },
      endPoint: 'Offers/Store/GetStoreOfferHeads',
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
    int pageSize,
    int pageNumber,
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {
        "pageSize": pageSize,
        "pageNumber": pageNumber,
        "search": "string",
        "type": "string",
        "offerHeadId": offerHeadId,
        "isOfferHeadId": false
      },
      endPoint: 'Offers/Store/GetStoreOffers',
      headers: {
        'Authorization': 'BEARER $token',
      },
    );
    List<OfferDetailsEntity> offerDetails = getOfferDetailsList(data);
    print(offerDetails);
    return offerDetails;
  }

  @override
  Future<DeleteOfferEntity> deleteOffer(
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "id": offerHeadId,
          "isOfferHead": true,
        },
        endPoint: "Offers/Store/DeleteOffer",
        headers: {
          'Authorization': 'BEARER $token',
        });
    DeleteOfferEntity delete = DeleteOfferModel.fromJson(data);
    print(delete);
    return delete;
  }

  @override
  Future<ChangeStatusOfferEntity> changeStatusOffer(
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "id": offerHeadId,
          "justActiveAndDis": true,
        },
        endPoint: "Offers/Store/EditOffer",
        headers: {
          'Authorization': 'BEARER $token',
        });
    ChangeStatusOfferEntity delete = ChangeStatusOfferModel.fromJson(data);
    print(delete);
    return delete;
  }
}
