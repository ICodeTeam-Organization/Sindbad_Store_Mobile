import '../../../domain/entities/sub_category_entity.dart';

class SubCategory extends SubCategoryEntity {
  int? id;
  int? parentCategoryId;
  String? name;
  dynamic shortName;
  String? description;
  String? categoryTypeName;
  int? categoryTypeNumber;
  String? imageUrl;

  SubCategory({
    this.id,
    this.parentCategoryId,
    this.name,
    this.shortName,
    this.description,
    this.categoryTypeName,
    this.categoryTypeNumber,
    this.imageUrl,
  }) : super(
            subCategoryId: id ?? 0000,
            subCategoryNameEntity: name ?? 'لا يوجد');

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'] as int?,
        parentCategoryId: json['parentCategoryId'] as int?,
        name: json['name'] as String?,
        shortName: json['shortName'] as dynamic,
        description: json['description'] as String?,
        categoryTypeName: json['categoryTypeName'] as String?,
        categoryTypeNumber: json['categoryTypeNumber'] as int?,
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'parentCategoryId': parentCategoryId,
        'name': name,
        'shortName': shortName,
        'description': description,
        'categoryTypeName': categoryTypeName,
        'categoryTypeNumber': categoryTypeNumber,
        'imageUrl': imageUrl,
      };
}
