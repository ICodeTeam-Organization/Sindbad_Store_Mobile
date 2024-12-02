import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/offer_products_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/offer_products_entity.dart';

abstract class NewOfferRemotDataSource {
  Future<List<OfferProductsEntity>> getOfferProducts(
    int pageSize,
    int pageNumber,
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
        "storeProductsFilter": 1,
        "pageSize": 20,
        "pageNumber": 7,
      },
      endPoint: 'Products/Store/GetStoreProductsWitheFilter',
      headers: {
        'Authorization': 'BEARER $token',
      },
    );
    List<OfferProductsEntity> offerProducts = getOfferProductsList(data);
    print(offerProducts);
    return offerProducts;
  }
}
