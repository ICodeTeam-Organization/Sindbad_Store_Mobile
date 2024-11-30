import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';

class OfferDetailsModel extends OfferDetailsEntity {
  int? id;
  dynamic offerPercentages;
  dynamic productPrice;
  String? productImageUrl;
  String? productName;
  dynamic finalPrice;
  dynamic amountYouBuy;
  dynamic amountYouGet;
  DateTime? offerStartDate;
  String? offerEndDate;
  bool? offerStatus;
  String? offerType;

  OfferDetailsModel({
    this.id,
    this.offerPercentages,
    this.productPrice,
    this.productImageUrl,
    this.productName,
    this.finalPrice,
    this.amountYouBuy,
    this.amountYouGet,
    this.offerStartDate,
    this.offerEndDate,
    this.offerStatus,
    this.offerType,
  }) : super(
          productId: id ?? 0,
          productTitle: productName ?? '',
          productImage: productImageUrl ?? '',
          discountRate: offerPercentages ?? 0,
          oldPrice: productPrice ?? 0,
          newPrice: finalPrice ?? 0,
          numberToBuy: amountYouBuy ?? 0,
          numberToGet: amountYouGet ?? 0,
        );

  factory OfferDetailsModel.fromJson(Map<String, dynamic> json) {
    return OfferDetailsModel(
      id: json['id'] as int?,
      offerPercentages: json['offerPercentages'] as dynamic,
      productPrice: json['productPrice'] as dynamic,
      productImageUrl: json['productImageUrl'] as String?,
      productName: json['productName'] as String?,
      finalPrice: json['finalPrice'] as dynamic,
      amountYouBuy: json['amountYouBuy'] as dynamic,
      amountYouGet: json['amountYouGet'] as dynamic,
      offerStartDate: json['offerStartDate'] == null
          ? null
          : DateTime.parse(json['offerStartDate'] as String),
      offerEndDate: json['offerEndDate'] as String?,
      offerStatus: json['offerStatus'] as bool?,
      offerType: json['offerType'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'offerPercentages': offerPercentages,
        'productPrice': productPrice,
        'productImageUrl': productImageUrl,
        'productName': productName,
        'finalPrice': finalPrice,
        'amountYouBuy': amountYouBuy,
        'amountYouGet': amountYouGet,
        'offerStartDate': offerStartDate?.toIso8601String(),
        'offerEndDate': offerEndDate,
        'offerStatus': offerStatus,
        'offerType': offerType,
      };
}
