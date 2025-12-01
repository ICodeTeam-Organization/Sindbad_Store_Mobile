class StoreCategoryEntity {
  final int id;
  final String categoryName;
  final String categoryImageUrl;

  StoreCategoryEntity({
    required this.id,
    required this.categoryName,
    required this.categoryImageUrl,
  });
}

class StoreImageEntity {
  final int id;
  final String imageUrl;

  StoreImageEntity({
    required this.id,
    required this.imageUrl,
  });
}
