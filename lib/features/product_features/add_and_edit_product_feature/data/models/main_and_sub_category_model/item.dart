import '../../../domain/entities/add_product_entities/main_category_entity.dart';
import 'sub_category.dart';

class Item extends MainCategoryEntity {
  int? id;
  String? name;
  dynamic shortName;
  String? description;
  String? imageUrl;
  String? categoryTypeName;
  int? categoryTypeNumber;
  List<SubCategory>? subCategories;

  Item({
    this.id,
    this.name,
    this.shortName,
    this.description,
    this.imageUrl,
    this.categoryTypeName,
    this.categoryTypeNumber,
    this.subCategories,
  }) : super(
            mainCategoryId: id ?? 0000,
            mainCategoryName: name ?? "لا يوجد",
            subCategory: subCategories ?? []);

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        name: json['name'] as String?,
        shortName: json['shortName'] as dynamic,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        categoryTypeName: json['categoryTypeName'] as String?,
        categoryTypeNumber: json['categoryTypeNumber'] as int?,
        subCategories: (json['subCategories'] as List<dynamic>?)
            ?.map((e) => SubCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'shortName': shortName,
        'description': description,
        'imageUrl': imageUrl,
        'categoryTypeName': categoryTypeName,
        'categoryTypeNumber': categoryTypeNumber,
        'subCategories': subCategories?.map((e) => e.toJson()).toList(),
      };
}
