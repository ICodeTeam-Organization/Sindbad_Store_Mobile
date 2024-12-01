class OrderDetailsEntity {
  final int idProduct;
  final String nameProduct;
  final String nameCategory;
  final String nameAttribute;
  final String valueAttribute;
  final double priceProduct;
  final int quantityProduct;
  final double total;
  final String imageUrl;
  final String numberProduct;

  OrderDetailsEntity(
      {required this.idProduct,
      required this.nameProduct,
      required this.nameCategory,
      required this.nameAttribute,
      required this.valueAttribute,
      required this.priceProduct,
      required this.quantityProduct,
      required this.total,
      required this.imageUrl,
      required this.numberProduct});
}
