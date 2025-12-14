import 'dart:io';

class EditProductFromStoreParams {
  final int id;
  // final String name;
  final num price;
  final String description;
  final File? mainImageFile;
  // final String number;
  final int? storeId;
  final int? offerId;
  final int? brandId;
  final int mainCategoryId;
  final List<File>? images;
  final List<String>? imagesUrl;
  final List<int> subCategoryIds;
  final List<Map<String, String>> newAttributes;
  final List<String>? tags;
  final num? oldPrice;
  final String? shortDescription;

  EditProductFromStoreParams(
      this.id,
      this.price,
      this.description,
      this.mainImageFile,
      this.storeId,
      this.offerId,
      this.brandId,
      this.mainCategoryId,
      this.images,
      this.imagesUrl,
      this.subCategoryIds,
      this.newAttributes,
      this.tags,
      this.oldPrice,
      this.shortDescription);
}
