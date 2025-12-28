import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/services/new_api_service.dart';
import 'package:sindbad_management_app/features/orders_feature/data/data_sources/all_order_remot_data_source.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_shipping_entity.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/entities/all_order_entity.dart';
import '../../domain/entities/order_cancel_entity.dart';
import '../models/all_order_model/all_orders_model.dart';
import '../models/cancel/order_cancel_model.dart';
import '../models/company_shipping/company_shipping_model/company_shipping_model.dart';
import '../models/invoice/order_invoice_model.dart';
import '../models/orders_details_model/orders_details_model.dart';
import '../models/shipping/order_shipping_model.dart';

class AllOrderRemotDataSourceImpl extends AllOrderRemotDataSource {
  final ApiService apiService;
  final NewApiService _newApiService;
  final FlutterSecureStorage secureStorage;

  AllOrderRemotDataSourceImpl(
      this.apiService, this.secureStorage, this._newApiService);

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  /// Handles errors from API calls and throws appropriate exceptions.
  /// Use this in catch blocks across all repository methods.
  Never _handleError(Object error, String operation) {
    if (error is DioException) {
      String message = 'Network error occurred';
      try {
        final data = error.response?.data;
        if (data is Map<String, dynamic> && data['message'] != null) {
          message = data['message'].toString();
        }
      } catch (_) {
        // Keep default message if parsing fails
      }
      throw Exception('$operation: $message');
    }
    throw Exception('$operation failed: $error');
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

  // Generic function to convert data to a list entities
  List<T> getListFromData<T>(
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
    return entities;
  }

  //! عرض جميع الطلبات
  List<OrderEntity> getAllOrderList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => OrderModel.fromJson(item));
  }

  @override
  Future<List<OrderEntity>> fetchAllOrder(
    List<int> statuses,
    bool? isUrgent,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  ) async {
    var endpoint = "Packages?owned=true";
    endpoint += "&pageSize=$pageSize&pageNumber=$pageNumber";
    endpoint += statuses.map((status) => "&statuses=$status").join();
    if (isUrgent != null && isUrgent) {
      endpoint += "&isUrgent=$isUrgent";
    }

    final response = await _newApiService.dio.get(endpoint);
    final data = response.data as Map<String, dynamic>;
    final items = data['data']['items'] as List<dynamic>;
    return items.map((item) => OrderModel.fromJson(item)).toList();
  }

  @override
  Future<List<OrderEntity>> fetchNewOrders(
    List<int> statuses,
    bool? isUrgent,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  ) async {
    try {
      var endpoint = "Packages?owned=true";
      endpoint += "&pageSize=$pageSize&pageNumber=$pageNumber";
      endpoint += statuses.map((status) => "&statuses=$status").join();
      if (isUrgent != null && isUrgent) {
        endpoint += "&isUrgent=$isUrgent";
      }

      final response = await _newApiService.dio.get(endpoint);
      final data = response.data as Map<String, dynamic>;
      final items = data['data']['items'] as List<dynamic>;
      return items.map((item) => OrderModel.fromJson(item)).toList();
    } catch (e) {
      _handleError(e, 'Fetch new orders');
    }
  }

  //! ارسال الفاتورة
  @override
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int? packageId,
    num? invoiceAmount,
    File invoiceImage,
    String invoiceNumber,
    DateTime invoiceDate,
    int invoiceType,
  ) async {
    String? token = await getToken();
    var data = await apiService.postRequestWithFileAndImage(
        endPoint: 'Packages/$packageId/Invoice',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: invoiceImage,
        data: {
          'InvoiceAmount': invoiceAmount,
          'InvoiceNumber': invoiceNumber,
          'Date': invoiceDate,
          'InvoiceType': invoiceType,
          'CompanyName': '',
          'ParcelNumber': '',
          'ShippingCompniesId': '',
          'PhoneNumper': '',
        });
    OrderInvoiceEntity invoice = OrderInvoiceModel.fromJson(data);
    return invoice;
  }

  //! عرض تفاصيل الطلب
  List<OrderDetailsEntity> fetchOrderDetailsList(Map<String, dynamic> data) {
    return getListFromData(data, (item) => OrdersDetailsModel.fromJson(item));
  }

  @override
  Future<List<OrderDetailsEntity>> fetchOrderDetails(
    int packageId,
  ) async {
    String? token = await getToken();
    var data = await apiService.post(
      data: {},
      endPoint: 'OrderDetails/Store/GetOrderDetails/$packageId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<OrderDetailsEntity> orderDetails = fetchOrderDetailsList(data);
    return orderDetails;
  }

  // !شحن الطلب
  @override
  Future<OrderShippingEntity> fetchOrderShipping(
      int packageId,
      DateTime invoiceDate,
      int shippingNumber,
      String shippingCompany,
      File shippingImages,
      int numberParcels,
      int shippingCompniesId,
      String phoneNumber) async {
    String? token = await getToken();
    var data = await apiService.postRequestWithFileAndImage(
        endPoint: 'Packages/$packageId/Ship',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: shippingImages,
        data: {
          'Date': invoiceDate,
          'InvoiceNumber': shippingNumber,
          'CompanyName': shippingCompany,
          'ParcelNumber': numberParcels,
          'ShippingCompniesId': shippingCompniesId,
          'PhoneNumper': phoneNumber,
          'InvoiceType': '',
          'InvoiceAmount': '',
          'ShopName': '',
          'ShopNumber': '',
          'ShopLocation': '',
        });
    OrderShippingEntity shipping = OrderShippingModel.fromJson(data);
    return shipping;
  }

  //! الغاء الطلب
  @override
  Future<OrderCancelEntity> fetchOrderCancel(
      int orderId, bool orderCancel, String reasonCancel) async {
    String? token = await getToken();
    var data = await apiService
        .post(endPoint: 'Orders/Store/RejectedTheOrder', headers: {
      'Authorization': 'Bearer $token',
    }, data: {
      'orderId': orderId,
      'cancelOrder': orderCancel,
      'cancelReason': reasonCancel,
    });
    OrderCancelEntity cancel = OrderCancelModel.fromJson(data);
    return cancel;
  }

  List<CompanyShippingEntity> getCompanyShipping(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => CompanyShippingModel.fromJson(item));
  }

  @override
/*************  ✨ Windsurf Command ⭐  *************/
  /// *****  26b88cd9-e0cd-451f-a616-d2014458a1aa  ******
  Future<List<CompanyShippingEntity>> fetchCompanyShipping(
    int pageNumber,
    int pageSize,
  ) async {
    String? token = await getToken();
    var data = await apiService.get(
      endPoint:
          'ShippingCompanies?pageNumber=$pageNumber&pageSize=$pageSize&isOfficial=true',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<CompanyShippingEntity> companyShipping = getCompanyShipping(data);
    return companyShipping;
  }
}
