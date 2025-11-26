import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';

class CategoryModels extends CategoryEntity {
  int? id;
  String? name;
  String? imageUrl;
  int? level;
  bool? isOfficial;
  int? parentId;
  int? type;
  bool? isDelete;

  CategoryModels({
    this.id,
    this.name,
    this.imageUrl,
    this.level,
    this.isOfficial,
    this.parentId,
    this.type,
    this.isDelete,
  }) : super(
            categoryId: id ?? 0,
            categoryName: name ?? '',
            categoryImage: imageUrl ?? '',
            categoryLevel: level ?? 0,
            categoryParentId: parentId ?? 0,
            categoryType: type ?? 0,
            isDeleted: isDelete ?? false);

  factory CategoryModels.fromJson(Map<String, dynamic> json) => CategoryModels(
        id: json['id'] as int?,
        name: json['name'] as String?,
        imageUrl: json['imageUrl'] as String?,
        level: json['level'] as int?,
        isOfficial: json['isOfficial'] as bool?,
        parentId: json['parentId'] as int?,
        type: json['type'] as int?,
        isDelete: json['isDeleted'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'level': level,
        'isOfficial': isOfficial,
        'parentId': parentId,
        'type': type,
        'isDeleted': isDelete
      };
}
