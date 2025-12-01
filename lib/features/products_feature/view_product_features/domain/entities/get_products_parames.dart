class ProductsParams {
  final int pageNumber;
  final int pageSize;
  final int? categoryId;

  ProductsParams(
    this.pageNumber,
    this.pageSize,
    this.categoryId,
  );
}
