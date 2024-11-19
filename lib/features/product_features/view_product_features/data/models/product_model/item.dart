class Item {
  int? id;
  String? productNumber;
  String? productName;
  String? productPrice;
  String? productImageUrl;
  String? productDescription;

  Item({
    this.id,
    this.productNumber,
    this.productName,
    this.productPrice,
    this.productImageUrl,
    this.productDescription,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        productNumber: json['productNumber'] as String?,
        productName: json['productName'] as String?,
        productPrice: json['productPrice'] as String?,
        productImageUrl: json['productImageUrl'] as String?,
        productDescription: json['productDescription'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'productNumber': productNumber,
        'productName': productName,
        'productPrice': productPrice,
        'productImageUrl': productImageUrl,
        'productDescription': productDescription,
      };
}
