class ProductEntity {
  final int id;
  final String imageUrl;
  final num rate;
  final num price;
  final num finalPrice;
  final num wholePrice;
  final String name;
  final int amountToBuy;
  final int amountToGet;
  final bool isOfficial;
  final bool isDisable;
  final String number;

  ProductEntity({
    required this.id,
    required this.imageUrl,
    required this.rate,
    required this.price,
    required this.finalPrice,
    required this.wholePrice,
    required this.name,
    required this.amountToBuy,
    required this.amountToGet,
    required this.isOfficial,
    required this.isDisable,
    required this.number,
  });
}
