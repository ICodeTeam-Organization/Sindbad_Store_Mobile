import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_cancel_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_shipping_entity.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/all_order_entity.dart';
import '../../domain/repos/all_order_repo.dart';
import '../data_sources/all_order_remot_data_source.dart';

class AllOrderRepoImpl extends AllOrderRepo {
  final AllOrderRemotDataSource allOrderRemotDataSource;

  AllOrderRepoImpl(
    this.allOrderRemotDataSource,
  );

  // basic fetch list Entity function
  Future<Either<Failure, List<T>>> fetchData<T>(
      Future<List<T>> Function() fetchFunction) async {
    try {
      var data = await fetchFunction();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

//////////////////////////////////
  ///All Order
  @override
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder({
    required bool isUrgen,
    required bool canceled,
    required bool delevred,
    required bool noInvoice,
    required bool unpaied,
    required bool paied,
    required int pageNumber,
    required int pageSize,
    required String storeId,
    // required String searchKeyword,
  }) {
    return fetchData(() => allOrderRemotDataSource.fetchAllOrder(
          isUrgen,
          canceled,
          delevred,
          noInvoice,
          unpaied,
          paied,
          pageNumber,
          pageSize,
          storeId,
          // searchKeyword,
        ));
  }

  //////////////////////////////////
  ///Order Details
  @override
  Future<Either<Failure, List<OrderDetailsEntity>>> fetchOrderDetails({
    required int orderId,
    required String orderNumber,
    required String billNumber,
    required String clock,
    required String date,
    required String itemNumber,
    required String paymentInfo,
    required String orderStatus,
  }) {
    return fetchData(() => allOrderRemotDataSource.fetchOrderDetails(
          orderId,
          orderNumber,
          billNumber,
          clock,
          date,
          itemNumber,
          paymentInfo,
          orderStatus,
        ));
  }

  Future<Either<Failure, T>> fetchDataOrder<T>(
      Future<T> Function() postDataFunction) async {
    try {
      var dataPosted = await postDataFunction();
      return right(dataPosted);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

///////////////////////////////
  ///Create Invoice
  @override
  Future<Either<Failure, OrderInvoiceEntity>> fetchOrderInvoice(
      {required int orderId,
      required String invoiceNumber,
      required num invoiceAmount,
      required int invoiceType,
      required File invoiceImage,
      required DateTime invoiceDate}) {
    return fetchDataOrder(() => allOrderRemotDataSource.fetchOrderInvoice(
        orderId,
        invoiceAmount,
        invoiceImage,
        invoiceNumber,
        invoiceDate,
        invoiceType));
  }

  @override
  Future<Either<Failure, OrderShippingEntity>> fetchOrderShipping(
      {required int orderId,
      required DateTime invoiceDate,
      required int shippingNumber,
      required String shippingCompany,
      required File shippingImages,
      required int numberParcels}) {
    return fetchDataOrder(() => allOrderRemotDataSource.fetchOrderShipping(
        orderId,
        invoiceDate,
        shippingNumber,
        shippingCompany,
        shippingImages,
        numberParcels));
  }

  @override
  Future<Either<Failure, OrderCancelEntity>> fetchOrderCancel(
      {required int orderId,
      required bool orderCancel,
      required String reasonCancel}) {
    return fetchDataOrder(() => allOrderRemotDataSource.fetchOrderCancel(
        orderId, orderCancel, reasonCancel));
  }
}
