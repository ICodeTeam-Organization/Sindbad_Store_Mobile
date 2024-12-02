class AddOfferDto {
  int? id;
  int? type;
  int? percentage;
  int? finalPrice;
  int? amountToBuy;
  int? amountToGet;
  DateTime? startDate;
  DateTime? endDate;
  int? productId;

  AddOfferDto({
    this.id,
    this.type,
    this.percentage,
    this.finalPrice,
    this.amountToBuy,
    this.amountToGet,
    this.startDate,
    this.endDate,
    this.productId,
  });

  factory AddOfferDto.fromJson(Map<String, dynamic> json) => AddOfferDto(
        id: json['id'] as int?,
        type: json['type'] as int?,
        percentage: json['percentage'] as int?,
        finalPrice: json['finalPrice'] as int?,
        amountToBuy: json['amountToBuy'] as int?,
        amountToGet: json['amountToGet'] as int?,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        productId: json['productId'] as int?,
      );

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
      };
}
