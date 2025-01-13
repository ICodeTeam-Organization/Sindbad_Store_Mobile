import '../../../domain/entities/edit_product_entities/product_details_entity.dart';
import 'attributes_with_value.dart';
import 'product_image.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  int? id;
  String? name;
  String? description;
  int? priceBeforOffer;
  int? priceAfterOffer;
  int? percentageOfDiscount;
  int? amountYouShouldToBuyForGetOffer;
  int? amountYouWillGetFromOffer;
  String? offerSentence;
  DateTime? offerStartDate;
  DateTime? offerEndDate;
  String? mainImageUrl;
  String? number;
  String? brandName;
  String? categoryName;
  int? oneStarCount;
  int? twoStarCount;
  int? threeStarCount;
  int? fourStarCount;
  int? fiveStarCount;
  List<ProductImage>? productImages;
  List<AttributesWithValue>? attributesWithValues;

  ProductDetailsModel({
    this.id,
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
    this.brandName,
    this.categoryName,
    this.oneStarCount,
    this.twoStarCount,
    this.threeStarCount,
    this.fourStarCount,
    this.fiveStarCount,
    this.productImages,
    this.attributesWithValues,
  }) : super(
          idProduct: id ?? 000,
          nameProduct: name ?? '',
          descriptionProduct: description ?? '',
          numberProduct: number ?? '',
          mainImageUrlProduct: mainImageUrl ?? '',
          imagesProduct: productImages ?? [],
          mainCategoryIdProduct: 000,
          subCategoryIdProduct: 000,
          brandIdProduct: 000,
          attributesWithValuesProduct: attributesWithValues ?? [],
        );

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        priceBeforOffer: json['priceBeforOffer'] as int?,
        priceAfterOffer: json['priceAfterOffer'] as int?,
        percentageOfDiscount: json['percentageOfDiscount'] as int?,
        amountYouShouldToBuyForGetOffer:
            json['amountYouShouldToBuyForGetOffer'] as int?,
        amountYouWillGetFromOffer: json['amountYouWillGetFromOffer'] as int?,
        offerSentence: json['offerSentence'] as String?,
        offerStartDate: json['offerStartDate'] == null
            ? null
            : DateTime.parse(json['offerStartDate'] as String),
        offerEndDate: json['offerEndDate'] == null
            ? null
            : DateTime.parse(json['offerEndDate'] as String),
        mainImageUrl: json['mainImageUrl'] as String?,
        number: json['number'] as String?,
        brandName: json['brandName'] as String?,
        categoryName: json['categoryName'] as String?,
        oneStarCount: json['oneStarCount'] as int?,
        twoStarCount: json['twoStarCount'] as int?,
        threeStarCount: json['threeStarCount'] as int?,
        fourStarCount: json['fourStarCount'] as int?,
        fiveStarCount: json['fiveStarCount'] as int?,
        productImages: (json['productImages'] as List<dynamic>?)
            ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
            .toList(),
        attributesWithValues: (json['attributesWithValues'] as List<dynamic>?)
            ?.map(
                (e) => AttributesWithValue.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

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
        'brandName': brandName,
        'categoryName': categoryName,
        'oneStarCount': oneStarCount,
        'twoStarCount': twoStarCount,
        'threeStarCount': threeStarCount,
        'fourStarCount': fourStarCount,
        'fiveStarCount': fiveStarCount,
        'productImages': productImages?.map((e) => e.toJson()).toList(),
        'attributesWithValues':
            attributesWithValues?.map((e) => e.toJson()).toList(),
      };
}
