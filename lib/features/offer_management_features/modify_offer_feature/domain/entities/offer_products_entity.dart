class OfferProductsEntity {
  final int? id;
  final int productId;
  final String productTitle;
  final String productImage;
  final num? discountRate;
  final num? oldPrice;
  final num? newPrice;
  final num? numberToBuy;
  final num? numberToGet;

  OfferProductsEntity({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.discountRate,
    required this.oldPrice,
    required this.newPrice,
    required this.numberToBuy,
    required this.numberToGet,
  });
}
