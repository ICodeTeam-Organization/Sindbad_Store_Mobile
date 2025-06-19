class OfferProductsEntity {
  final int? productOfferId;
  final int productId;
  final String productTitle;
  final String productImage;
  final num? discountRate;
  final num? oldPrice;
  final num? newPrice;
  final num? numberToBuy;
  final num? numberToGet;
  bool isDeleted = false;

  OfferProductsEntity({
    required this.productOfferId,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.discountRate,
    required this.oldPrice,
    required this.newPrice,
    required this.numberToBuy,
    required this.numberToGet,
    this.isDeleted = false,
  });
}
