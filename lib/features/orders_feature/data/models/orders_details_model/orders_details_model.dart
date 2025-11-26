import 'package:sindbad_management_app/features/orders_feature/data/models/orders_details_model/product_attribute.dart';

import '../../../domain/entities/order_detalis_entity.dart';

class OrdersDetailsModel extends OrderDetailsEntity {
  int? id;
  int? productId;
  String? productName;
  String? categoryName;
  List<ProductAttribute>? productAttributes;
  double? productPrice;
  int? productQuantity;
  double? totalPrice;
  String? productImageUrl;
  String? productNumber;

  OrdersDetailsModel({
    this.id,
    this.productId,
    this.productName,
    this.categoryName,
    this.productAttributes,
    this.productPrice,
    this.productQuantity,
    this.totalPrice,
    this.productImageUrl,
    this.productNumber,
  }) : super(
            idProduct: id!,
            nameProduct: productName ?? '',
            nameCategory: categoryName ?? '',
            productAttri: productAttributes ?? [],
            priceProduct: productPrice ?? 0,
            quantityProduct: productQuantity ?? 0,
            total: totalPrice ?? 0,
            imageUrl: productImageUrl ?? '',
            numberProduct: productNumber ?? '');

  factory OrdersDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrdersDetailsModel(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      productName: json['productName'] as String?,
      categoryName: json['categoryName'] as String?,
      productAttributes: (json['productAttributes'] as List<dynamic>?)
          ?.map((e) => ProductAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      productPrice: json['productPrice'] as double?,
      productQuantity: json['productQuantity'] as int?,
      totalPrice: json['totalPrice'] as double?,
      productImageUrl: json['productImageUrl'] as String?,
      productNumber: json['productNumber'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'productName': productName,
        'categoryName': categoryName,
        'productAttributes': productAttributes?.map((e) => e.toJson()).toList(),
        'productPrice': productPrice,
        'productQuantity': productQuantity,
        'totalPrice': totalPrice,
        'productImageUrl': productImageUrl,
        'productNumber': productNumber,
      };
}
