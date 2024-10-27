import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/store_app_features/home/domain/entities/all_order_entity.dart';

import '../../../../core/api_service.dart';
import '../models/all_order_model/all_order_model.dart';

abstract class AllOrderRemotDataSource {
  Future<List<AllOrderEntity>> fetchAllOrder(
      String storeId, int pageNumber, int pageSize, int searchKeyword);
}

class AllOrderRemotDataSourceImpl extends AllOrderRemotDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  AllOrderRemotDataSourceImpl(this.apiService, this.secureStorage);

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  // Generic function to convert data to a list of items entities
  List<T> getListItemsFromData<T>(
      Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson) {
    List<T> entities = [];

    if (data['data'] is List) {
      for (var item in data['data']) {
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
  List<AllOrderEntity> getMyOrderList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => AllOrderModel.fromJson(item));
  }

  @override
  Future<List<AllOrderEntity>> fetchAllOrder(
      String storeId, int pageNumber, int pageSize, int searchKeyword) async {
    String? token = await getToken();
    var data = await apiService.get(
      endPoint:
          'https://icode-sendbad-store.runasp.net/api/Orders/Market/OrdersPage/GetAllOrdersByStoreIdWitheFilterstring/11/1/10/1',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<AllOrderEntity> orders = getMyOrderList(data);
    return orders;
  }
}
