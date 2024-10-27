class OrderProcessingEntity {
  final String nameProduct;
  final num orderDetailsId;
  final num priceProduct;
  final String description;
  final String productImage;
  final int quantites;

  OrderProcessingEntity(
      {required this.orderDetailsId,
      required this.nameProduct,
      required this.priceProduct,
      required this.description,
      required this.productImage,
      required this.quantites});
}
