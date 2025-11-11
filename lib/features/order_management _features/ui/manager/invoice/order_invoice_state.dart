part of 'order_invoice_cubit.dart';

sealed class OrderInvoiceState {}

final class OrderInvoiceInitial extends OrderInvoiceState {}

final class OrderInvoiceLoading extends OrderInvoiceState {}

final class OrderInvoiceFailuer extends OrderInvoiceState {
  final String errMessage;

  OrderInvoiceFailuer({required this.errMessage});
}

final class OrderInvoiceSuccess extends OrderInvoiceState {
  final OrderInvoiceEntity serverMessage;

  OrderInvoiceSuccess({required this.serverMessage});
}
