import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';

import '../../../../../core/errors/failure.dart';

part 'order_invoice_state.dart';

class OrderInvoiceCubit extends Cubit<OrderInvoiceState> {
  OrderInvoiceCubit(this.orderInvoiceUsecasse) : super(OrderInvoiceInitial());
  final OrderInvoiceUsecase orderInvoiceUsecasse;

  Future<void> fechOrderInvoice(
      {required int? packageId,
      required num? invoiceAmount,
      required File invoiceImage,
      required String invoiceNumber,
      required DateTime invoiceDate,
      required int invoiceType}) async {
    emit(OrderInvoiceLoading());
    try {
      var params = OrderInvoiceParam(
        packageId: packageId,
        invoiceAmounts: invoiceAmount,
        invoiceNumbers: invoiceNumber,
        invoiceImages: invoiceImage,
        invoiceDate: invoiceDate,
        invoiceType: invoiceType,
      );
      final result = await orderInvoiceUsecasse.execute(params);

      result.fold(
          (failure) => emit(OrderInvoiceFailuer(errMessage: failure.message)),
          (serverMessage) {
        if (serverMessage.isSuccess == true) {
          emit(OrderInvoiceSuccess(serverMessage: serverMessage));
        } else {
          emit(OrderInvoiceFailuer(errMessage: serverMessage.serverMessage));
        }
      });
    } catch (e) {
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(OrderInvoiceFailuer(errMessage: failure.message));
      } else {
        emit(OrderInvoiceFailuer(errMessage: e.toString()));
      }
    }
  }
}
