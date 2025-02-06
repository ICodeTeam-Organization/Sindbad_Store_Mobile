import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/models/invoice/order_invoice_model.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_shipping_entity.dart';
import '../../../../core/api_service.dart';
import '../../domain/entities/all_order_entity.dart';
import '../../domain/entities/order_cancel_entity.dart';
import '../models/all_order_model/all_orders_model.dart';
import '../models/cancel/order_cancel_model.dart';
import '../models/shipping/order_shipping_model.dart';
import '../models/orders_details_model/orders_details_model.dart';

abstract class AllOrderRemotDataSource {
  //! All Order
  Future<List<AllOrderEntity>> fetchAllOrder(
    bool isUrgen,
    bool canceled,
    bool delevred,
    bool noInvoice,
    bool unpaied,
    bool paied,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  );

  //! Order Deatails
  Future<List<OrderDetailsEntity>> fetchOrderDetails(
    int packageId,
  );

  //! Order Invoice
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int packageId,
    num invoiceAmount,
    File invoiceImage,
    String invoiceNumber,
    DateTime invoiceDate,
    int invoiceType,
  );

  //! Order Shipping
  Future<OrderShippingEntity> fetchOrderShipping(
      int packageId,
      DateTime invoiceDate,
      int shippingNumber,
      String shippingCompany,
      File shippingImages,
      int numberParcels,
      int shippingCompniesId,
      String phoneNumber);

  //! Order Cancrl
  Future<OrderCancelEntity> fetchOrderCancel(
    int orderId,
    bool orderCancel,
    String reasonCancel,
  );
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
  List<AllOrderEntity> getAllOrderList(Map<String, dynamic> data) {
    return getListItemsFromData(data, (item) => AllOrdersModel.fromJson(item));
  }

  @override
  Future<List<AllOrderEntity>> fetchAllOrder(
    bool isUrgen,
    bool canceled,
    bool delevred,
    bool noInvoice,
    bool unpaied,
    bool paied,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  ) async {
    String? token = await getToken();
    final decodeToken = JwtDecoder.decode(token!);
    var data = await apiService.post(
      data: {
        'isUrgen': isUrgen,
        'canceled': canceled,
        'delevred': delevred,
        'noInvoice': noInvoice,
        'unpaied': unpaied,
        'paied': paied,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
        'storeId': decodeToken['Id']
        // 'search': srearchKeyword,
      },
      endPoint: 'Orders/Store/GetStoreOrders',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<AllOrderEntity> orders = getAllOrderList(data);
    return orders;
  }

  //! ارسال الفاتورة
  @override
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int packageId,
    num invoiceAmount,
    File invoiceImage,
    String invoiceNumber,
    DateTime invoiceDate,
    int invoiceType,
  ) async {
    String? token = await getToken();
    var data = await apiService.postRequestWithFileAndImage(
        endPoint:
            'OrderDetailsInvoices/CreateOrderDetailsInvoice?packageId=$packageId&InvoiceNumber=$invoiceNumber&InvoiceAmount=$invoiceAmount&Date=$invoiceDate&InvoiceType=$invoiceDate',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: invoiceImage,
        data: {
          'InvoiceAmount': invoiceAmount,
          'InvoiceNumber': invoiceNumber,
          'Date': invoiceDate,
          'packageId': packageId,
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
        endPoint:
            'ShippingInformations/CreateShippingInformation?PackageId=$packageId&Date=$invoiceDate&InvoiceNumber=$shippingNumber&CompanyName=$shippingCompany&PhoneNumper=$phoneNumber&ParcelNumber=$numberParcels',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: shippingImages,
        data: {
          'packageId': packageId,
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
}
