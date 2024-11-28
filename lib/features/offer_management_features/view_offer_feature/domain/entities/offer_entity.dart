class OfferEntity {
  final int offerId;
  final String offerTitle;
  final String typeName;
  final bool isActive;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final int? numberToBuy;
  final int? numberToGet;
  final int? rate;

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
    this.rate,
  });
}
