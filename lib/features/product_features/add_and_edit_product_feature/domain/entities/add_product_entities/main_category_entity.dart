import 'package:hive/hive.dart';
part 'main_category_entity.g.dart';

@HiveType(typeId: 0)
class CategoryEntity extends HiveObject {
  @HiveField(0)
  final int categoryId;
  @HiveField(1)
  final String categoryName;
  @HiveField(2)
  final String categoryImage;
  @HiveField(3)
  final int categoryLevel;
  @HiveField(4)
  final int categoryParentId;
  @HiveField(5)
  final int categoryType;
  @HiveField(6)
  final bool isDeleted;

  CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryLevel,
    required this.categoryParentId,
    required this.categoryType,
    required this.isDeleted,
  });
}
