import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  ///////////////////////////
  ///All Order
  Future<List<AllOrderEntity>> fetchAllOrder(
      bool isUrgen,
      bool canceled,
      bool delevred,
      bool noInvoice,
      bool unpaied,
      bool paied,
      int pageNumber,
      int pageSize,
      String srearchKeyword);
  /////////////////////////////////
  ///Order Deatails
  Future<List<OrderDetailsEntity>> fetchOrderDetails(
      int orderId,
      String orderNumber,
      String billNumber,
      String clock,
      String date,
      String itemNumber,
      String paymentInfo,
      String orderStatus);
  ///////////////////////////////
  ///Order Invoice
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int orderId,
    num invoiceAmount,
    File invoiceImage,
    String invoiceNumber,
    DateTime invoiceDate,
    int invoiceType,
  );
  ///////////////////
  ///Order Shipping
  Future<OrderShippingEntity> fetchOrderShipping(
      int orderId,
      DateTime invoiceDate,
      int shippingNumber,
      String shippingCompany,
      File shippingImages,
      int numberParcels);
  /////////////////////
  ///Order Cancrl
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
    print('this the list added in data source $entities');

    return entities;
  }

  // get MyOrder List function
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
      String srearchKeyword) async {
    String? token = await getToken();
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
        'search': srearchKeyword,
      },
      endPoint: 'Orders/Store/GetStoreOrdersnew',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<AllOrderEntity> orders = getAllOrderList(data);
    print(orders);
    return orders;
  }

  //////////////////////////////////////////////////////////////
  ///ارسال الفاتورة
  List<int> nums = [5];
  @override
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int orderId,
    num invoiceAmount,
    File invoiceImage,
    String invoiceNumber,
    DateTime invoiceDate,
    int invoiceType,
  ) async {
    String? token = await getToken();
    // FormData formData = FormData();
    // formData = FormData.fromMap(
    //   {
    //     'InvoiceAmount': 5.5,
    //     'InvoiceNumber': '5',
    //     'Date': DateTime.now().toString(),
    //     'orderDetailsId': nums.map((e) => e.toString()).toList(),
    //     'InvoiceType': 1,
    //   },
    // );

    var data = await apiService.postRequestWithFileAndImage(
        endPoint:
            'OrderDetailsInvoices/CreateOrderDetailsInvoice?orderId=$orderId&InvoiceNumber=$invoiceNumber&InvoiceAmount=$invoiceAmount&Date=$invoiceDate&InvoiceType=$invoiceType',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: invoiceImage,
        data: {
          'InvoiceAmount': invoiceAmount,
          'InvoiceNumber': invoiceNumber,
          'Date': invoiceDate,
          'orderId': orderId,
          'InvoiceType': invoiceType,
          'CompanyName': '',
          'ParcelNumber': '',
        });
    OrderInvoiceEntity invoice = OrderInvoiceModel.fromJson(data);
    print(invoice);
    return invoice;
  }

  //////////////////////////////////////////////
  //Order Details List function
  List<OrderDetailsEntity> fetchOrderDetailsList(Map<String, dynamic> data) {
    return getListItemsFromData(
        data, (item) => OrdersDetailsModel.fromJson(item));
  }

  @override
  Future<List<OrderDetailsEntity>> fetchOrderDetails(
      int orderId,
      String orderNumber,
      String billNumber,
      String clock,
      String date,
      String itemNumber,
      String paymentInfo,
      String orderStatus) async {
    String? token = await getToken();
    var data = await apiService.post(
      // data: {"orderId": orderId},
      data: {},
      endPoint: 'OrderDetails/Store/GetStoreOrderDetails/$orderId',
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    List<OrderDetailsEntity> orderDetails = fetchOrderDetailsList(data);
    return orderDetails;
  }

  @override
  Future<OrderShippingEntity> fetchOrderShipping(
      int orderId,
      DateTime invoiceDate,
      int shippingNumber,
      String shippingCompany,
      File shippingImages,
      int numberParcels) async {
    String? token = await getToken();
    var data = await apiService.postRequestWithFileAndImage(
        endPoint:
            'ShippingInformations/CreateShippingInformation2?orderId=$orderId&Date=$invoiceDate&InvoiceNumber=$shippingNumber&CompanyName=$shippingCompany&ParcelNumber=$numberParcels',
        headers: {
          'Authorization': 'Bearer $token',
        },
        file: shippingImages,
        data: {
          'orderId': orderId,
          'Date': invoiceDate,
          'InvoiceNumber': shippingNumber,
          'CompanyName': shippingCompany,
          'ParcelNumber': numberParcels,
          'InvoiceType': '',
          'InvoiceAmount': '',
        });
    OrderShippingEntity shipping = OrderShippingModel.fromJson(data);
    print(shipping);
    return shipping;
  }

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
    print(cancel);
    return cancel;
  }
}
