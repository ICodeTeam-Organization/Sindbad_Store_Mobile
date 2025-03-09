import '../../../domain/entities/edit_product_entities/product_details_entity.dart';
import 'attributes_with_value.dart';
import 'product_image.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  final int id;
  String? name;
  String? description;
  num? priceBeforOffer;
  num? priceAfterOffer;
  num? percentageOfDiscount;
  num? amountYouShouldToBuyForGetOffer;
  num? amountYouWillGetFromOffer;
  String? offerSentence;
  DateTime? offerStartDate;
  DateTime? offerEndDate;
  String? mainImageUrl;
  String? number;
  int? brandId;
  String? brandName;
  String? categoryName;
  List<int>? mainCategoriesIds;
  List<int>? subCategoriesIds;
  List<String>? mainCategoriesNames;
  List<String>? subCategoriesNames;
  int? oneStarCount;
  int? twoStarCount;
  int? threeStarCount;
  int? fourStarCount;
  int? fiveStarCount;
  List<ProductImage>? productImages;
  List<AttributesWithValue>? attributesWithValues;

  ProductDetailsModel({
    required this.id,
    this.name,
    this.description,
    this.priceBeforOffer,
    this.priceAfterOffer,
    this.percentageOfDiscount,
    this.amountYouShouldToBuyForGetOffer,
    this.amountYouWillGetFromOffer,
    this.offerSentence,
    this.offerStartDate,
    this.offerEndDate,
    this.mainImageUrl,
    this.number,
    this.brandId,
    this.brandName,
    this.categoryName,
    this.mainCategoriesIds,
    this.subCategoriesIds,
    this.mainCategoriesNames,
    this.subCategoriesNames,
    this.oneStarCount,
    this.twoStarCount,
    this.threeStarCount,
    this.fourStarCount,
    this.fiveStarCount,
    this.productImages,
    this.attributesWithValues,
  }) : super(
          idProduct: id,
          nameProduct: name ?? '',
          descriptionProduct: description ?? '',
          numberProduct: number ?? '',
          priceProduct: priceBeforOffer ?? 0,
          mainImageUrlProduct: mainImageUrl ?? '',
          imagesProduct: productImages ?? [],
          mainCategoryIdProduct: (mainCategoriesIds != null && mainCategoriesIds.isNotEmpty)
              ? mainCategoriesIds[0]
              : 0,
          mainCategoryNameProduct: categoryName ?? '',
          subCategoryIdProduct: subCategoriesIds ?? [],
          subCategoriesName: (subCategoriesNames != null && subCategoriesNames.isNotEmpty)
              ? subCategoriesNames[0]
              : 'error in model data',
          brandIdProduct: brandId,
          brandNameProduct: brandName ?? 'لا يوجد',
          attributesWithValuesProduct: attributesWithValues ?? [],
        );

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String?,
      description: json['description'] as String?,
      priceBeforOffer: json['priceBeforOffer'] as num?,
      priceAfterOffer: json['priceAfterOffer'] as num?,
      percentageOfDiscount: json['percentageOfDiscount'] as num?,
      amountYouShouldToBuyForGetOffer: json['amountYouShouldToBuyForGetOffer'] as num?,
      amountYouWillGetFromOffer: json['amountYouWillGetFromOffer'] as num?,
      offerSentence: json['offerSentence'] as String?,
      offerStartDate: json['offerStartDate'] == null
          ? null
          : DateTime.tryParse(json['offerStartDate'] as String),
      offerEndDate: json['offerEndDate'] == null
          ? null
          : DateTime.tryParse(json['offerEndDate'] as String),
      mainImageUrl: json['mainImageUrl'] as String?,
      number: json['number'] as String?,
      brandId: json['brandId'] as int?,
      brandName: json['brandName'] as String?,
      categoryName: json['categoryName'] as String?,
      mainCategoriesIds: json['mainCategoriesIds'] != null
          ? List<int>.from((json['mainCategoriesIds'] as List).whereType<int>())
          : [],
      subCategoriesIds: json['subCategoriesIds'] != null
          ? List<int>.from((json['subCategoriesIds'] as List).whereType<int>())
          : [],
      mainCategoriesNames: json['mainCategoriesNames'] != null
          ? List<String>.from((json['mainCategoriesNames'] as List).whereType<String>())
          : [],
      subCategoriesNames: json['subCategoriesNames'] != null
          ? List<String>.from((json['subCategoriesNames'] as List).whereType<String>())
          : [],
      oneStarCount: json['oneStarCount'] as int?,
      twoStarCount: json['twoStarCount'] as int?,
      threeStarCount: json['threeStarCount'] as int?,
      fourStarCount: json['fourStarCount'] as int?,
      fiveStarCount: json['fiveStarCount'] as int?,
      productImages: json['productImages'] != null
          ? (json['productImages'] as List)
              .map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      attributesWithValues: json['attributesWithValues'] != null
          ? (json['attributesWithValues'] as List)
              .map((e) => AttributesWithValue.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'priceBeforOffer': priceBeforOffer,
        'priceAfterOffer': priceAfterOffer,
        'percentageOfDiscount': percentageOfDiscount,
        'amountYouShouldToBuyForGetOffer': amountYouShouldToBuyForGetOffer,
        'amountYouWillGetFromOffer': amountYouWillGetFromOffer,
        'offerSentence': offerSentence,
        'offerStartDate': offerStartDate?.toIso8601String(),
        'offerEndDate': offerEndDate?.toIso8601String(),
        'mainImageUrl': mainImageUrl,
        'number': number,
        'brandId': brandId,
        'brandName': brandName,
        'categoryName': categoryName,
        'mainCategoriesIds': mainCategoriesIds,
        'subCategoriesIds': subCategoriesIds,
        'mainCategoriesNames': mainCategoriesNames,
        'subCategoriesNames': subCategoriesNames,
        'oneStarCount': oneStarCount,
        'twoStarCount': twoStarCount,
        'threeStarCount': threeStarCount,
        'fourStarCount': fourStarCount,
        'fiveStarCount': fiveStarCount,
        'productImages': productImages?.map((e) => e.toJson()).toList(),
        'attributesWithValues': attributesWithValues?.map((e) => e.toJson()).toList(),
      };
}
