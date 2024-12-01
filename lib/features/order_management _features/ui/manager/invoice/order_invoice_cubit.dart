import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_invoice_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';

import '../../../../../core/errors/failure.dart';

part 'order_invoice_state.dart';

class OrderInvoiceCubit extends Cubit<OrderInvoiceState> {
  OrderInvoiceCubit(this.orderInvoiceUsecasse) : super(OrderInvoiceInitial());
  final OrderInvoiceUsecase orderInvoiceUsecasse;

  Future<void> fechOrderInvoice(
      List<int> ids,
      num invoiceAmount,
      File invoiceImage,
      String invoiceNumber,
      DateTime invoiceDate,
      int invoiceType) async {
    emit(OrderInvoiceLoading());
    try {
      var params = OrderInvoiceParam(
        ids: ids,
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
          print("Omar and Qais");
        } else {
          emit(OrderInvoiceFailuer(errMessage: serverMessage.serverMessage));
          print("fjdiofghsjkdfhsjkahfjkhglk");
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
