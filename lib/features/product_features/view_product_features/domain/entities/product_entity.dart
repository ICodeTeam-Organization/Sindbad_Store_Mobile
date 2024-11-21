class ProductEntity {
  final int productid;
  final String productName;
  final String productNumber;
  final num productPrice;
  final String productImageUrl;

  ProductEntity(
      {required this.productid,
      required this.productName,
      required this.productNumber,
      required this.productPrice,
      required this.productImageUrl});
}
