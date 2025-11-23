import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/models/company_shipping/company_shipping_model/company_shipping_model.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/models/invoice/order_invoice_model.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/company_shipping_entity.dart';
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
    List<int> statuses,
    bool? isUrgent,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  );
  //! All Order
  Future<List<AllOrderEntity>> fetchNewOrders(
    List<int> statuses,
    bool? isUrgent,
    int pageNumber,
    int pageSize,
  );

  //! Order Deatails
  Future<List<OrderDetailsEntity>> fetchOrderDetails(
    int packageId,
  );

  //! Order Invoice
  Future<OrderInvoiceEntity> fetchOrderInvoice(
    int? packageId,
    num? invoiceAmount,
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
  //! Company Shipping
  Future<List<CompanyShippingEntity>> fetchCompanyShipping(
    int pageNumber,
    int pageSize,
  );
}
