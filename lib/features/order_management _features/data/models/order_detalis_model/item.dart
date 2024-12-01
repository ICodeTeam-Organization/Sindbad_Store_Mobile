// // import 'product_attribute.dart';

// // class Item {
// //   int? id;
// //   int? productId;
// //   String? productName;
// //   String? categoryName;
// //   List<ProductAttribute>? productAttributes;
// //   int? productPrice;
// //   int? productQuantity;
// //   int? totalPrice;
// //   String? productImageUrl;
// //   String? productNumber;

// //   Item({
// //     this.id,
// //     this.productId,
// //     this.productName,
// //     this.categoryName,
// //     this.productAttributes,
// //     this.productPrice,
// //     this.productQuantity,
// //     this.totalPrice,
// //     this.productImageUrl,
// //     this.productNumber,
// //   });

// //   factory Item.fromJson(Map<String, dynamic> json) => Item(
// //         id: json['id'] as int?,
// //         productId: json['productId'] as int?,
// //         productName: json['productName'] as String?,
// //         categoryName: json['categoryName'] as String?,
// //         productAttributes: (json['productAttributes'] as List<dynamic>?)
// //             ?.map((e) => ProductAttribute.fromJson(e as Map<String, dynamic>))
// //             .toList(),
// //         productPrice: json['productPrice'] as int?,
// //         productQuantity: json['productQuantity'] as int?,
// //         totalPrice: json['totalPrice'] as int?,
// //         productImageUrl: json['productImageUrl'] as String?,
// //         productNumber: json['productNumber'] as String?,
// //       );

// //   Map<String, dynamic> toJson() => {
// //         'id': id,
// //         'productId': productId,
// //         'productName': productName,
// //         'categoryName': categoryName,
// //         'productAttributes': productAttributes?.map((e) => e.toJson()).toList(),
// //         'productPrice': productPrice,
// //         'productQuantity': productQuantity,
// //         'totalPrice': totalPrice,
// //         'productImageUrl': productImageUrl,
// //         'productNumber': productNumber,
// //       };
// // }
// import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';

// import 'product_attribute.dart';

// class Item extends OrderDetailsEntity {
//   final int id;
//   final int productId;
//   final String productName;
//   final String categoryName;
//   final List<ProductAttribute>? productAttributes;
//   final double productPrice;
//   final int productQuantity;
//   final double totalPrice;
//   final String productImageUrl;
//   final String productNumber;

//   Item({
//     required this.id,
//     required this.productId,
//     required this.productName,
//     required this.categoryName,
//     required this.productAttributes,
//     required this.productPrice,
//     required this.productQuantity,
//     required this.totalPrice,
//     required this.productImageUrl,
//     required this.productNumber,
//   }) : super(idProduct: productId, nameProduct: productName, nameCategory: categoryName, nameAttribute: productAttributes[].attributeName, valueAttribute: productAttributes[].attributeValue, priceProduct: productPrice, quantityProduct: productQuantity, total: totalPrice, imageUrl: productImageUrl, numberProduct: productNumber);

//   factory Item.fromJson(Map<String, dynamic> json) {
//     var attributesList = json['productAttributes'] as List;
//     List<ProductAttribute> attributes = attributesList
//         .map((attribute) => ProductAttribute.fromJson(attribute))
//         .toList();

//     return Item(
//       id: json['id'],
//       productId: json['productId'],
//       productName: json['productName'],
//       categoryName: json['categoryName'],
//       productAttributes: attributes,
//       productPrice: json['productPrice'].toDouble(),
//       productQuantity: json['productQuantity'],
//       totalPrice: json['totalPrice'].toDouble(),
//       productImageUrl: json['productImageUrl'],
//       productNumber: json['productNumber'],
//     );
//   }
// }
