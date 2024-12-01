import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';
import '../../../../core/errors/failure.dart';
import '../entities/all_order_entity.dart';
import '../entities/order_invoice_entity.dart';

abstract class AllOrderRepo {
  ///////////////////////////
  ///All orders
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder(
      {required bool isUrgen,
      required bool canceled,
      required bool delevred,
      required bool noInvoice,
      required bool unpaied,
      required bool paied,
      required int pageNumber,
      required int pageSize,
      required String srearchKeyword});
  /////////////////////////////
  ///Order Deatalis
  Future<Either<Failure, List<OrderDetailsEntity>>> fetchOrderDetails({
    required int orderId,
    required String orderNumber,
    required String billNumber,
    required String clock,
    required String date,
    required String itemNumber,
    required String paymentInfo,
    required String orderStatus,
  });

  /////////////////////////////////
  ///Order Invoice
  Future<Either<Failure, OrderInvoiceEntity>> fetchOrderInvoice(
      {required List<int> ids,
      required String invoiceNumber,
      required num invoiceAmount,
      required int invoiceType,
      required File invoiceImage,
      required DateTime invoiceDate});
}
