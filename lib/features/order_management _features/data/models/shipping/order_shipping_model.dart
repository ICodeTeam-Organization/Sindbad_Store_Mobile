import '../../domain/entities/order_shipping_entity.dart';

class OrderShippingModel extends OrderShippingEntity {
  bool? success;
  String? message;

  OrderShippingModel({this.success, this.message})
      : super(
            isSuccess: success ?? false,
            serverMessage: message ?? 'Server Error');

  factory OrderShippingModel.fromJson(Map<String, dynamic> json) {
    return OrderShippingModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
      };
}
