class OfferEntity {
  final int offerId;

  final String offerTitle;
  final String typeName;
  final bool isActive;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final num? numberToBuy;
  final num? numberToGet;
  final num? discountRate;

  OfferEntity({
    required this.offerId,
    required this.offerTitle,
    required this.typeName,
    required this.isActive,
    required this.startOffer,
    required this.endOffer,
    required this.countProducts,
    this.numberToBuy,
    this.numberToGet,
    this.discountRate,
  });
}
