import 'package:sindbad_management_app/features/orders_feature/data/models/orders_details_model/product_attribute.dart';

class OrderDetailsEntity {
  final int idProduct;
  final String nameProduct;
  final List<ProductAttribute> productAttri;
  final String nameCategory;
  final double priceProduct;
  final int quantityProduct;
  final double total;
  final String imageUrl;
  final String numberProduct;

  OrderDetailsEntity(
      {required this.idProduct,
      required this.nameProduct,
      required this.productAttri,
      required this.nameCategory,
      required this.priceProduct,
      required this.quantityProduct,
      required this.total,
      required this.imageUrl,
      required this.numberProduct});
}
