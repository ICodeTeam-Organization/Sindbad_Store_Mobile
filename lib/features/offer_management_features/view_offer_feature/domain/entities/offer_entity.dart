class OfferEntity {
  final int offerId;
  final String offerName;
  final String offerType;
  final bool offerStatus;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;

  OfferEntity({
    required this.offerId,
    required this.offerName,
    required this.offerType,
    required this.offerStatus,
    required this.startOffer,
    required this.endOffer,
    required this.countProducts,
  });
}
