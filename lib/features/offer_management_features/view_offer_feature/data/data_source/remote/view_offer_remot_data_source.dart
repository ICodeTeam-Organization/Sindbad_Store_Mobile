import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_details_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/models/post_response_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/post_response_entity.dart';

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
  Future<PostResponseEntity> deleteOffer(
    int offerHeadId,
  );
  Future<PostResponseEntity> changeStatusOffer(
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
    return entities;
  }

  // get OfferEntity List function---------------------------------------------------------------
  List<OfferEntity> getOfferList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => OfferModel.fromJson(item));
  }

  @override
  Future<List<OfferEntity>> getOffer(int pageSize, int pageNumber) async {
    String? token = await getToken();
    // var data = await apiService.post(
    var data = await apiService.get(
      // data: {
      //   "pageSize": 100,
      //   "pageNumber": pageNumber,
      // },
      // endPoint: 'Offers/Store/GetStoreOfferHeads',
      // endPoint: 'Offers/Store/GetStoreOfferHeads?PageSize=$pageSize&PageNumber=$pageNumber',
      endPoint: 'Offers/Store/GetStoreOfferHeads?PageSize=100&PageNumber=$pageNumber',
      headers: {'Authorization': 'BEARER $token'},
    );
    List<OfferEntity> response = getOfferList(data);
    return response;
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
    // var data = await apiService.post(
    var data = await apiService.get(
      // data: {
      //   "pageSize": 100,
      //   "pageNumber": pageNumber,
      //   "offerHeadId": offerHeadId,
      //   "isOfferHeadId": false
      // },
      // endPoint: 'Offers/Store/GetStoreOffers',
      // endPoint: 'Offers/Store/GetStoreOffers?PageSize=$pageSize&PageNumber=$pageNumber&OfferHeadId=$offerHeadId',
      endPoint: 'Offers/Store/GetStoreOffers?PageSize=100&PageNumber=$pageNumber&OfferHeadId=$offerHeadId',
      headers: {'Authorization': 'BEARER $token'},
    );
    List<OfferDetailsEntity> response = getOfferDetailsList(data);
    return response;
  }

  // get DeleteOfferEntity a function-------------------------------------------------
  @override
  Future<PostResponseEntity> deleteOffer(
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "id": offerHeadId,
          "isOfferHead": true,
        },
        endPoint: "Offers/Store/DeleteOffer",
        headers: {'Authorization': 'BEARER $token'});
    PostResponseEntity response = PostResponseModel.fromJson(data);
    return response;
  }

  // get ChangeStatusOfferEntity a function-------------------------------------------------
  @override
  Future<PostResponseEntity> changeStatusOffer(
    int offerHeadId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "id": offerHeadId,
          "justActiveAndDis": true,
        },
        endPoint: "Offers/Store/EditOffer",
        headers: {'Authorization': 'BEARER $token'});
    PostResponseEntity response = PostResponseModel.fromJson(data);
    return response;
  }
}
