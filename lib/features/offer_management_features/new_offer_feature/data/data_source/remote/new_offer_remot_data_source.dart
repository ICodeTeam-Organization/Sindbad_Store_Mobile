import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/add_offer_model/add_offer_dto.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/add_offer_model/add_offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/offer_products_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/offer_products_entity.dart';

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
    // List<AddOfferDto>? listProduct,
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
    print('this the list added in data source $entities');

    return entities;
  }

  // get OfferProductsEntity List function-------------------------------------------------
  List<OfferProductsEntity> getOfferProductsList(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OfferProductsModel.fromJson(item));
  }

  @override
  Future<List<OfferProductsEntity>> getOfferProducts(
    int pageNumber,
    int pageSize,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {
        "pageSize": 10,
        "pageNumber": 1,
      },
      endPoint: 'Products/GetProductsWitheFilter?returnDtoName=1',
      headers: {
        'Authorization': 'BEARER $token',
      },
    );
    List<OfferProductsEntity> offerProducts = getOfferProductsList(data);
    print(offerProducts);
    return offerProducts;
  }

  @override
  Future<AddOfferEntity> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    // List<AddOfferDto>? listProduct,
    List<Map<String, dynamic>>? listProduct,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
        data: {
          "name": offerTitle, //
          "description": "string",
          "startDate": startOffer.toIso8601String(),
          "endDate": endOffer.toIso8601String(),
          "isActive": true,
          "numberOfOrders": countProducts,
          "offerHeadType": typeName,
          "addOfferDtos": listProduct
        },
        endPoint: "Offers/Store/AddOffer",
        headers: {
          'Authorization': 'BEARER $token',
        });
    AddOfferEntity add = AddOfferModel.fromJson(data);
    print(add);
    return add;
  }
}
