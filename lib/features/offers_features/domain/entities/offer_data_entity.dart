import 'package:sindbad_management_app/features/offers_features/data/models/offer_data_model/offer_head_offer.dart';

class OfferDataEntity {
  final int offerId;
  final String offerTitle;
  final int offerType;
  final DateTime startOffer;
  final DateTime endOffer;
  final num? numberToBuy;
  final num? numberToGet;
  final num? discountRate;
  // final List<OfferHeadOffersEntity> listProduct;
  final List<OfferHeadOffer> listProduct;

  OfferDataEntity({
    required this.offerId,
    required this.offerTitle,
    required this.offerType,
    required this.startOffer,
    required this.endOffer,
    this.numberToBuy,
    this.numberToGet,
    this.discountRate,
    required this.listProduct,
  });
}

// class OfferHeadOffersEntity {
//   final int? id;
//   // int? type;
//   final int? percentage;
//   final dynamic finalPrice;
//   final dynamic amountToBuy;
//   final dynamic amountToGet;
//   // DateTime? startDate;
//   // dynamic endDate;
//   final dynamic productId;
//   final String? name;
//   final String? mainImageUrl;
//   final dynamic priceBeforeDiscount;

//   OfferHeadOffersEntity({required this.id, required this.percentage, required this.finalPrice, required this.amountToBuy, required this.amountToGet, required this.productId, required this.name, required this.mainImageUrl, required this.priceBeforeDiscount});
// }
