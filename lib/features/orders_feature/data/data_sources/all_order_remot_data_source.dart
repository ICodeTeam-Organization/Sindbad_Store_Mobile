import 'dart:io';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_shipping_entity.dart';
import '../../domain/entities/all_order_entity.dart';
import '../../domain/entities/order_cancel_entity.dart';

abstract class AllOrderRemotDataSource {
  //! All Order
  Future<List<OrderEntity>> fetchAllOrder(
    List<int> statuses,
    bool? isUrgent,
    int pageNumber,
    int pageSize,
    // String storeId,
    // String srearchKeyword,
  );
  //! All Order
  Future<List<OrderEntity>> fetchNewOrders(
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
