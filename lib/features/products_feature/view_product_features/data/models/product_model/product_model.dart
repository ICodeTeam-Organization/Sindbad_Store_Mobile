import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final int? id;
  final String? storeId;
  final String? productNumber; // default will be '0' if null
  final String? productName;
  final num? productPrice;
  final String? productImageUrl;
  final String? productDescription;
  final num? rate;
  final num? finalPrice;
  final int? wholePrice;
  final int? amountToBuy;
  final int? amountToGet;
  final bool? isOfficial;
  final bool? isDisable;

  ProductModel({
    this.id,
    this.storeId,
    this.productNumber,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.productDescription,
    this.rate,
    this.finalPrice,
    this.wholePrice,
    this.amountToBuy,
    this.amountToGet,
    this.isOfficial,
    this.isDisable,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        storeId: json['storeId'] as String?,
        productNumber: json['number']?.toString() ?? "0", // ensure string
        productName: json['name'] as String?,
        productPrice: json['price'] as num?,
        productImageUrl: json['imageUrl'] as String?,
        productDescription: json['description'] as String?,
        rate: json['rate'] as num?,
        finalPrice: json['finalPrice'] as num?,
        wholePrice: json['wholePrice'] as int?,
        amountToBuy: json['amountToBuy'] as int?,
        amountToGet: json['amountToGet'] as int?,
        isOfficial: json['isOfficial'] as bool?,
        isDisable: json['isDisable'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeId': storeId,
        'number':
            productNumber, // this may not be necessary cause the json does not return any product Number.
        'name': productName,
        'price': productPrice,
        'imageUrl': productImageUrl,
        'description': productDescription,
        'rate': rate,
        'finalPrice': finalPrice,
        'wholePrice': wholePrice,
        'amountToBuy': amountToBuy,
        'amountToGet': amountToGet,
        'isOfficial': isOfficial,
        'isDisable': isDisable,
      };
}
