import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.imageUrl,
    required super.rate,
    required super.price,
    required super.finalPrice,
    required super.wholePrice,
    required super.name,
    required super.amountToBuy,
    required super.amountToGet,
    required super.isOfficial,
    required super.isDisable,
    required super.number,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      imageUrl: json['imageUrl'] ?? "",
      rate: json['rate'] ?? 0,
      price: json['price'] ?? 0,
      finalPrice: json['finalPrice'] ?? 0,
      wholePrice: json['wholePrice'] ?? 0,
      name: json['name'] ?? "",
      amountToBuy: json['amountToBuy'] ?? 0,
      amountToGet: json['amountToGet'] ?? 0,
      isOfficial: json['isOfficial'] ?? false,
      isDisable: json['isDisable'] ?? false,
      number: json['number'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "imageUrl": imageUrl,
      "rate": rate,
      "price": price,
      "finalPrice": finalPrice,
      "wholePrice": wholePrice,
      "name": name,
      "amountToBuy": amountToBuy,
      "amountToGet": amountToGet,
      "isOfficial": isOfficial,
      "isDisable": isDisable,
      "number": number,
    };
  }
}
