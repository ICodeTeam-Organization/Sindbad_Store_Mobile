import 'package:sindbad_management_app/store_app_features/home/domain/entities/all_order_entity.dart';

class AllOrderModel extends AllOrderEntity {
  String? orderNumber;
  DateTime? createdAt;
  int? quantity;

  AllOrderModel({this.orderNumber, this.createdAt, this.quantity})
      : super(
            orderNum: orderNumber ?? "0",
            orderDate: createdAt,
            productNum: quantity ?? 0);

  factory AllOrderModel.fromJson(Map<String, dynamic> json) => AllOrderModel(
        orderNumber: json['orderNumber'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        quantity: json['quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
        'createdAt': createdAt?.toIso8601String(),
        'quantity': quantity,
      };
}
