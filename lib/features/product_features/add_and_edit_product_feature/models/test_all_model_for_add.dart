// Step 1: Create Model Classes for the API response

// Main Response Model
class CategoriesResponseModel {
  final bool success;
  final String message;
  final CategoriesData data;

  CategoriesResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoriesResponseModel(
      success: json['success'],
      message: json['message'],
      data: CategoriesData.fromJson(json['data']),
    );
  }
}

// CategoriesData Model
class CategoriesData {
  final List<CategoryItem> items;
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int pageSize;

  CategoriesData({
    required this.items,
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) {
    return CategoriesData(
      items: (json['items'] as List)
          .map((item) => CategoryItem.fromJson(item))
          .toList(),
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
    );
  }
}

// CategoryItem Model
class CategoryItem {
  final int id;
  final String categoryName;
  final String categoryImageUrl;
  final List<SubCategoryItem> subCategories;

  CategoryItem({
    required this.id,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.subCategories,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryImageUrl: json['categoryImageUrl'],
      subCategories: (json['subCategories'] as List)
          .map((sub) => SubCategoryItem.fromJson(sub))
          .toList(),
    );
  }
}

// SubCategoryItem Model
class SubCategoryItem {
  final int id;
  final String subCategoryName;
  final String subCategoryImageUrle;

  SubCategoryItem({
    required this.id,
    required this.subCategoryName,
    required this.subCategoryImageUrle,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'],
      subCategoryName: json['subCategoryName'],
      subCategoryImageUrle: json['subCategoryImageUrle'],
    );
  }
}
