import '../../../domain/entities/order_cancel_entity.dart';

class OrderCancelModel extends OrderCancelEntity {
  bool? success;
  String? message;

  OrderCancelModel({this.success, this.message})
      : super(
            isSuccess: success ?? false,
            serverMessage: message ?? 'Server Error');

  factory OrderCancelModel.fromJson(Map<String, dynamic> json) {
    return OrderCancelModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
