import 'dart:io';

class AddProductParams {
  final String name;
  final num price;
  final String description;
  final File mainImageFile;
  final String number;
  // i don't use it
  final int? storeId;
  final int? offerId;
  //
  final int? brandId;
  final int mainCategoryId;
  final List<File> images;
  final List<int> subCategoryIds;
  final List<Map<String, String>> newAttributes;
  final List<String> tags;
  final num oldPrice;
  final String shortDescription;
  AddProductParams(
      {required this.name,
      required this.price,
      required this.description,
      required this.mainImageFile,
      required this.number,
      //
      required this.storeId,
      required this.offerId,
      //
      required this.brandId,
      required this.mainCategoryId,
      required this.images,
      required this.subCategoryIds,
      required this.newAttributes,
      required this.tags,
      required this.oldPrice,
      required this.shortDescription});
}
