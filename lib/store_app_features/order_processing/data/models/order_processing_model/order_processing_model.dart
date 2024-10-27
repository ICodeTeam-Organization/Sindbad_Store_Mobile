import 'package:sindbad_management_app/store_app_features/order_processing/domain/entities/order_processing_entity.dart';

class OrderProcessingModel extends OrderProcessingEntity {
  int? orderDetailId;
  String? productName;
  int? productPrice;
  String? productDescription;
  String? productMainImageUrl;
  int? quantity;

  OrderProcessingModel({
    this.orderDetailId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productMainImageUrl,
    this.quantity,
  }) : super(
            orderDetailsId: orderDetailId!,
            nameProduct: productName ?? "",
            priceProduct: productPrice ?? 0,
            description: productDescription ?? "",
            productImage: productMainImageUrl ?? "",
            quantites: quantity ?? 0);

  factory OrderProcessingModel.fromJson(Map<String, dynamic> json) {
    return OrderProcessingModel(
      orderDetailId: json['orderDetailId'] as int?,
      productName: json['productName'] as String?,
      productPrice: json['productPrice'] as int?,
      productDescription: json['productDescription'] as String?,
      productMainImageUrl: json['productMainImageUrl'] as String?,
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderDetailId': orderDetailId,
        'productName': productName,
        'productPrice': productPrice,
        'productDescription': productDescription,
        'productMainImageUrl': productMainImageUrl,
        'quantity': quantity,
      };
}
