import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/offer_products_entity.dart';

class OfferProductsModel extends OfferProductsEntity {
  int? id;
  String? storeId;
  String? productNumber;
  String? productName;
  dynamic productPrice;
  String? productImageUrl;
  String? productDescription;

  OfferProductsModel({
    this.id,
    this.storeId,
    this.productNumber,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.productDescription,
  }) : super(
          productId: id ?? 0,
          productTitle: productName ?? '',
          productImage: productImageUrl ?? '',
          productIPrice: productPrice ?? 0,
        );

  factory OfferProductsModel.fromJson(Map<String, dynamic> json) {
    return OfferProductsModel(
      id: json['id'] as int?,
      storeId: json['storeId'] as String?,
      productNumber: json['productNumber'] as String?,
      productName: json['productName'] as String?,
      productPrice: json['productPrice'] as dynamic,
      productImageUrl: json['productImageUrl'] as String?,
      productDescription: json['productDescription'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'storeId': storeId,
        'productNumber': productNumber,
        'productName': productName,
        'productPrice': productPrice,
        'productImageUrl': productImageUrl,
        'productDescription': productDescription,
      };
}
