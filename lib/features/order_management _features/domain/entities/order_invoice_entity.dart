import 'dart:io';

class OrderInvoiceEntity {
  final bool isSuccess;
  final String serverMessage;
  final String invoiceDate;
  final String invoiceNumbers;
  final num invoiceAmounts;
  final File? invoiceImages;
  final int invoiceId;
  final int invoiceType;

  OrderInvoiceEntity({
    required this.isSuccess,
    required this.serverMessage,
    required this.invoiceDate,
    required this.invoiceNumbers,
    required this.invoiceAmounts,
    required this.invoiceImages,
    required this.invoiceId,
    required this.invoiceType,
  });
}
