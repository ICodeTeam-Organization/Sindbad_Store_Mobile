import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';

class OfferProductsModel extends OfferProductsEntity {
  int? id;
  String? storeId;
  String? number;
  String? name;
  dynamic price;
  String? mainImageUrl;
  String? description;

  OfferProductsModel({
    this.id,
    this.storeId,
    this.number,
    this.name,
    this.price,
    this.mainImageUrl,
    this.description,
  }) : super(
          productOfferId: 0,
          productId: id ?? 0,
          productTitle: name ?? '',
          productImage: mainImageUrl ?? '',
          discountRate: 0,
          oldPrice: price ?? 0,
          newPrice: 0,
          numberToBuy: 0,
          numberToGet: 0,
        );

  factory OfferProductsModel.fromJson(Map<String, dynamic> json) =>
      OfferProductsModel(
        id: json['id'] as int?,
        storeId: json['storeId'] as String?,
        number: json['number'] as String?,
        name: json['name'] as String?,
        price: json['price'] as dynamic,
        mainImageUrl: json['mainImageUrl'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeId': storeId,
        'number': number,
        'name': name,
        'price': price,
        'mainImageUrl': mainImageUrl,
        'description': description,
      };
}
