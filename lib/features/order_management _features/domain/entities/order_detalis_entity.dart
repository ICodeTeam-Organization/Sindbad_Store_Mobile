class OrderDetailsEntity {
  final int idProduct;
  final String nameProduct;
  final String nameCategory;
  final String nameAttribute1;
  final String nameAttribute2;
  final String valueAttribute1;
  final String valueAttribute2;
  final double priceProduct;
  final int quantityProduct;
  final double total;
  final String imageUrl;
  final String numberProduct;

  OrderDetailsEntity(
      {required this.idProduct,
      required this.nameProduct,
      required this.nameCategory,
      required this.nameAttribute1,
      required this.nameAttribute2,
      required this.valueAttribute1,
      required this.valueAttribute2,
      required this.priceProduct,
      required this.quantityProduct,
      required this.total,
      required this.imageUrl,
      required this.numberProduct});
}
