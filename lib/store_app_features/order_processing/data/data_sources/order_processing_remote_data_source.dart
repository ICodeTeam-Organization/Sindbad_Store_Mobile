import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/domain/entities/order_processing_entity.dart';

import '../../../../core/api_service.dart';
import '../models/order_processing_model/order_processing_model.dart';

abstract class OrderProcessingRemoteDataSource {
  Future<List<OrderProcessingEntity>> fetchOrderProcessing(
    String storeId,
    int orderId,
  );
}

class OrderProcessingRemotDataSourceImpl
    extends OrderProcessingRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;

  OrderProcessingRemotDataSourceImpl(this.apiService, this.secureStorage);

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
  List<OrderProcessingEntity> getOrderProcessingList(
      Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OrderProcessingModel.fromJson(item));
  }

  @override
  Future<List<OrderProcessingEntity>> fetchOrderProcessing(
      String storeId, int orderId) async {
    String? token = await getToken();
    var data = await apiService.get(
      endPoint:
          'https://icode-sendbad-store.runasp.net/api/Orders/Market/OrdersPage/GetAllOrdersByStoreIdWitheFilterstring/11/1/10/1',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<OrderProcessingEntity> orders = getOrderProcessingList(data);
    return orders;
  }
}
