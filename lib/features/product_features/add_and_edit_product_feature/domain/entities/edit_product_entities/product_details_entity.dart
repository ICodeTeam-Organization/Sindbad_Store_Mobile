import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/edit_product_entities/product_attribute_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/edit_product_entities/product_images_entity.dart';

class ProductDetailsEntity {
  final int idProduct;
  final String nameProduct;
  final String descriptionProduct;
  final String numberProduct;
  final num priceProduct;
  final String mainImageUrlProduct;
  final List<ProductImagesEntity> imagesProduct;
  final int mainCategoryIdProduct;
  final String mainCategoryNameProduct;
  final List<int> subCategoryIdProduct;
  final int? brandIdProduct;
  final List<ProductAttributeEntity> attributesWithValuesProduct;

  ProductDetailsEntity({
    required this.idProduct,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.numberProduct,
    required this.priceProduct,
    required this.mainImageUrlProduct,
    required this.imagesProduct,
    required this.mainCategoryIdProduct,
    required this.mainCategoryNameProduct,
    required this.subCategoryIdProduct,
    required this.brandIdProduct,
    required this.attributesWithValuesProduct,
  });
}
