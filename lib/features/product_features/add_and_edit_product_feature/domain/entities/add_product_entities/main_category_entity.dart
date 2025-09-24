class CategoryEntity {
  final int categoryId;
  final String categoryName;
  final String categoryImage;
  final int categoryLevel;
  final int categoryParentId;
  final int categoryType;

  CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryLevel,
    required this.categoryParentId,
    required this.categoryType,
  });
}
