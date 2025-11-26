import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_invoice_entity.dart';

class OrderInvoiceModel extends OrderInvoiceEntity {
  bool? success;
  String? message;

  OrderInvoiceModel({
    this.success,
    this.message,
  }) : super(
          isSuccess: success ?? false,
          serverMessage: message ?? "",
        );

  factory OrderInvoiceModel.fromJson(Map<String, dynamic> json) {
    return OrderInvoiceModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
