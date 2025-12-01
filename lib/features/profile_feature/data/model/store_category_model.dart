import 'package:sindbad_management_app/features/profile_feature/domin/entity/store_category_entity.dart';

class StoreCategoryModel extends StoreCategoryEntity {
  StoreCategoryModel({
    required super.id,
    required super.categoryName,
    required super.categoryImageUrl,
  });

  factory StoreCategoryModel.fromJson(Map<String, dynamic> json) {
    return StoreCategoryModel(
      id: json['id'] ?? 0,
      categoryName: json['categoryName'] ?? '',
      categoryImageUrl: json['categoryImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categoryName": categoryName,
      "categoryImageUrl": categoryImageUrl,
    };
  }
}
