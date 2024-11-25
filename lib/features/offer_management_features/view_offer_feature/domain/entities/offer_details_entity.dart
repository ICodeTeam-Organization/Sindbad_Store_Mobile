class OfferDetailsEntity {
  final int offerId;
  final int productId;
  final String productName;
  final String productImage;
  final int? lastPrice;
  final int? newPrice;
  final int? buysCount;
  final int? freesCount;

  OfferDetailsEntity({
    required this.offerId,
    required this.productId,
    required this.productName,
    required this.productImage,
    this.lastPrice,
    this.newPrice,
    this.buysCount,
    this.freesCount,
  });
}
