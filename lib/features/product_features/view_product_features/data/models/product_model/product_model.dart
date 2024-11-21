import '../../../domain/entities/product_entity.dart';
import 'data.dart';

class ProductModel extends ProductEntity {
  bool? success;
  String? message;
  Data? data;

  ProductModel({
    this.success,
    this.message,
    this.data,
  }) : super(
          productid:
              data?.items?.isNotEmpty == true ? data!.items![0].id ?? 0 : 0,
          productName: data?.items?.isNotEmpty == true
              ? data!.items![0].productName ?? ''
              : '',
          productNumber: data?.items?.isNotEmpty == true
              ? data!.items![0].productNumber ?? ''
              : '',
          productPrice: data?.items?.isNotEmpty == true
              ? num.tryParse(data!.items![0].productPrice ?? '0') ?? 0
              : 0,
          productImageUrl: data?.items?.isNotEmpty == true
              ? data!.items![0].productImageUrl ?? ''
              : '',
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };

  /// إنشاء قائمة من المنتجات كـ ProductEntity
  List<ProductEntity> toProductEntities() {
    return data?.items?.map((item) {
          return ProductEntity(
            productid: item.id ?? 0,
            productName: item.productName ?? '',
            productNumber: item.productNumber ?? '',
            productPrice: num.tryParse(item.productPrice ?? '0') ?? 0,
            productImageUrl: item.productImageUrl ?? '',
          );
        }).toList() ??
        [];
  }
}
