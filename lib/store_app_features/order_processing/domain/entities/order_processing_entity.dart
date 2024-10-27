class OrderProcessingEntity {
  final String productName;
  final num productPrice;
  final String productDescription;
  final String productMainImageUrl;
  final int quantity;

  OrderProcessingEntity(
      {required this.productName,
      required this.productPrice,
      required this.productDescription,
      required this.productMainImageUrl,
      required this.quantity});
}
