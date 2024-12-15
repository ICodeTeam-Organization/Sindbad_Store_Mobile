import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/sub_category_entity.dart';

class MainCategoryEntity {
  final int mainCategoryId;
  final String mainCategoryName;
  final List<SubCategoryEntity> subCategory;
  MainCategoryEntity({
    required this.mainCategoryId,
    required this.mainCategoryName,
    required this.subCategory,
  });
}
