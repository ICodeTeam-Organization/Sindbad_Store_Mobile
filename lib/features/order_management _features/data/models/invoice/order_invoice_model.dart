import 'package:sindbad_management_app/features/order_management%20_features/data/models/invoice/data.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_invoice_entity.dart';

class OrderInvoiceModel extends OrderInvoiceEntity {
  bool? success;
  String? message;
  Data? data;

  OrderInvoiceModel({this.success, this.message, this.data})
      : super(
            isSuccess: success ?? false,
            serverMessage: message ?? "",
            invoiceDate: data?.date ?? '',
            invoiceNumbers: data?.invoiceNumber ?? "",
            invoiceAmounts: data?.invoiceAmount ?? 0,
            invoiceImages: data?.invoiceImageUrl,
            invoiceId: 0,
            invoiceType: 1);

  factory OrderInvoiceModel.fromJson(Map<String, dynamic> json) {
    return OrderInvoiceModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
