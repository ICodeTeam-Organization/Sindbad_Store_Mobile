import '../../../domain/entities/edit_product_entities/product_images_entity.dart';

class ProductImage extends ProductImagesEntity {
  String? imageUrl;

  ProductImage({this.imageUrl}) : super(imageUrlProduct: imageUrl ?? '');

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
      };
}
