class OfferHeadOffer {
  int? id;
  int? type;
  dynamic percentage;
  dynamic finalPrice;
  dynamic amountToBuy;
  dynamic amountToGet;
  DateTime? startDate;
  DateTime? endDate;
  int? productId;
  String? name;
  String? mainImageUrl;
  dynamic priceBeforeDiscount;

  OfferHeadOffer({
    this.id,
    this.type,
    this.percentage,
    this.finalPrice,
    this.amountToBuy,
    this.amountToGet,
    this.startDate,
    this.endDate,
    this.productId,
    this.name,
    this.mainImageUrl,
    this.priceBeforeDiscount,
  });

  factory OfferHeadOffer.fromJson(Map<String, dynamic> json) {
    return OfferHeadOffer(
      id: json['id'] as int?,
      type: json['type'] as int?,
      percentage: json['percentage'] as dynamic,
      finalPrice: json['finalPrice'] as dynamic,
      amountToBuy: json['amountToBuy'] as dynamic,
      amountToGet: json['amountToGet'] as dynamic,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      productId: json['productId'] as int?,
      name: json['name'] as String?,
      mainImageUrl: json['mainImageUrl'] as String?,
      priceBeforeDiscount: json['priceBeforeDiscount'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'percentage': percentage,
        'finalPrice': finalPrice,
        'amountToBuy': amountToBuy,
        'amountToGet': amountToGet,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'productId': productId,
        'name': name,
        'mainImageUrl': mainImageUrl,
        'priceBeforeDiscount': priceBeforeDiscount,
      };
}
