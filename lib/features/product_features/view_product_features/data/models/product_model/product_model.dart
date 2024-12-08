import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  int? id;
  String? storeId;
  String? productNumber;
  String? productName;
  num? productPrice;
  String? productImageUrl;
  String? productDescription;

  ProductModel({
    this.id,
    this.storeId,
    this.productNumber,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.productDescription,
  }) : super(
            productid: id ?? 0,
            productName: productName ?? 'لا يوجد',
            productNumber: productNumber ?? '0',
            productPrice: productPrice ?? 0.0,
            productImageUrl: productImageUrl ?? '');

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        storeId: json['storeId'] as String?,
        // productNumber: json['productNumber'] as String?,
        productNumber: json['number'] as String?,
        productName: json['name'] as String?,
        // productName: json['productName'] as String?,
        productPrice: json['price'] as num?,
        // productPrice: json['productPrice'] as num?,
        // productImageUrl: json['productImageUrl'] as String?,
        productImageUrl: json['mainImageUrl'] as String?,
        productDescription: json['description'] as String?,
        // productDescription: json['productDescription'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeId': storeId,
        // 'productNumber': productNumber,
        // 'productName': productName,
        // 'productPrice': productPrice,
        // 'productImageUrl': productImageUrl,
        // 'productDescription': productDescription,
        "number": productNumber,
        "name": productName,
        "price": productPrice,
        "mainImageUrl": productImageUrl,
        "description": productDescription
      };
}
