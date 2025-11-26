import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';

class MainCategoryForViewEntity {
  final int mainCategoryId;
  final String mainCategoryName;

  MainCategoryForViewEntity({
    required this.mainCategoryId,
    required this.mainCategoryName,
  });

  /// Factory constructor to create from a CategoryEntity
  factory MainCategoryForViewEntity.fromCategoryEntity(
      CategoryEntity category) {
    return MainCategoryForViewEntity(
      mainCategoryId: category.categoryId,
      mainCategoryName: category.categoryName,
    );
  }
}
