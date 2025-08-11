import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_shipping_entity.dart';
import '../../../../core/errors/failure.dart';
import '../entities/all_order_entity.dart';
import '../entities/company_shipping_entity.dart';
import '../entities/order_cancel_entity.dart';
import '../entities/order_invoice_entity.dart';

abstract class AllOrderRepo {
  //! All orders
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder({
    required List<int> statuses,
    required bool isUrgent,
    required int pageNumber,
    required int pageSize,
    // required String storeId,
    // required String searchKeyword
  });

  //! Order Deatalis
  Future<Either<Failure, List<OrderDetailsEntity>>> fetchOrderDetails({
    required int packageId,
  });

  //! Create Invoice
  Future<Either<Failure, OrderInvoiceEntity>> fetchOrderInvoice(
      {required int? packageId,
      required String invoiceNumber,
      required num? invoiceAmount,
      required int invoiceType,
      required File invoiceImage,
      required DateTime invoiceDate});

  //! Shipping Invoice
  Future<Either<Failure, OrderShippingEntity>> fetchOrderShipping({
    required int packageId,
    required DateTime invoiceDate,
    required int shippingNumber,
    required String shippingCompany,
    required File shippingImages,
    required int numberParcels,
    required int shippingCompniesId,
    required String phoneNumber,
  });

  //! Order Cancel
  Future<Either<Failure, OrderCancelEntity>> fetchOrderCancel({
    required int orderId,
    required bool orderCancel,
    required String reasonCancel,
  });

  //! CompanyShipping
  Future<Either<Failure, List<CompanyShippingEntity>>> fetchCompanyShipping({
    required int pageNumber,
    required int pageSize,
  });
}
