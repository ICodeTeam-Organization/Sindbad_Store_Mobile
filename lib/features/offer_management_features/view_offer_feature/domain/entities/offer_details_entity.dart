class OfferDetailsEntity {
  final int productId;
  final String productTitle;
  final String productImage;
  final String typeName;
  final int? oldPrice;
  final int? newPrice;
  final int? numberToBuy;
  final int? numberToGet;

  OfferDetailsEntity({
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.typeName,
    required this.oldPrice,
    required this.newPrice,
    required this.numberToBuy,
    required this.numberToGet,
  });
}
