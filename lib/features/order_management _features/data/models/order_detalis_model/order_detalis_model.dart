// // import 'item.dart';
// // class OrderDetalisModel {
// //   List<Item>? items;
// //   int? totalCount;
// //   int? totalPages;
// //   int? currentPage;
// //   int? pageSize;

// //   OrderDetalisModel({
// //     this.items,
// //     this.totalCount,
// //     this.totalPages,
// //     this.currentPage,
// //     this.pageSize,
// //   });

// //   factory OrderDetalisModel.fromJson(Map<String, dynamic> json) {
// //     return OrderDetalisModel(
// //       items: (json['items'] as List<dynamic>?)
// //           ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
// //           .toList(),
// //       totalCount: json['totalCount'] as int?,
// //       totalPages: json['totalPages'] as int?,
// //       currentPage: json['currentPage'] as int?,
// //       pageSize: json['pageSize'] as int?,
// //     );
// //   }

// //   Map<String, dynamic> toJson() => {
// //         'items': items?.map((e) => e.toJson()).toList(),
// //         'totalCount': totalCount,
// //         'totalPages': totalPages,
// //         'currentPage': currentPage,
// //         'pageSize': pageSize,
// //       };
// // }

import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';

class Product extends OrderDetailsEntity {
  final int id;
  final int productId;
  final String productName;
  final String categoryName;
  final List<ProductAttribute> productAttributes;
  final double productPrice;
  final int productQuantity;
  final double totalPrice;
  final String productImageUrl;
  final String productNumber;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.categoryName,
    required this.productAttributes,
    required this.productPrice,
    required this.productQuantity,
    required this.totalPrice,
    required this.productImageUrl,
    required this.productNumber,
  }) : super(
            idProduct: productId,
            nameProduct: productName,
            nameCategory: categoryName,
            nameAttribute: productAttributes[0].attributeName,
            valueAttribute: productAttributes[0].attributeValue,
            priceProduct: productPrice,
            quantityProduct: productQuantity,
            total: totalPrice,
            imageUrl: productImageUrl,
            numberProduct: productNumber);

  factory Product.fromJson(Map<String, dynamic> json) {
    var attributesList = json['productAttributes'] as List;
    List<ProductAttribute> attributes = attributesList
        .map((attribute) => ProductAttribute.fromJson(attribute))
        .toList();

    return Product(
      id: json['id'],
      productId: json['productId'],
      productName: json['productName'],
      categoryName: json['categoryName'],
      productAttributes: attributes,
      productPrice: json['productPrice'].toDouble(),
      productQuantity: json['productQuantity'],
      totalPrice: json['totalPrice'].toDouble(),
      productImageUrl: json['productImageUrl'],
      productNumber: json['productNumber'],
    );
  }
}

class ProductAttribute {
  final String attributeName;
  final String attributeValue;

  ProductAttribute({
    required this.attributeName,
    required this.attributeValue,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      attributeName: json['attributeName'],
      attributeValue: json['attributeValue'],
    );
  }
}

class ProductResponse {
  final List<Product> items;
  final int totalCount;
  final int totalPages;
  final int currentPage;
  final int pageSize;

  ProductResponse({
    required this.items,
    required this.totalCount,
    required this.totalPages,
    required this.currentPage,
    required this.pageSize,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<Product> products =
        itemsList.map((item) => Product.fromJson(item)).toList();

    return ProductResponse(
      items: products,
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
    );
  }
}
