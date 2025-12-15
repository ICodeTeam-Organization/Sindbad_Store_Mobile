import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  int? id;
  String? offerName;
  String? offerDesc; // Added this field
  DateTime? offerStartDate;
  DateTime? offerEndDate;
  bool? offerStatus;
  String? offerTypeName;
  int? amountToBuy; // Changed from dynamic to int
  int? amountToGet; // Changed from dynamic to int
  double? percent; // Changed from dynamic to double
  int? quantityOfProduct; // Fixed typo

  OfferModel({
    this.id,
    this.offerName,
    this.offerDesc, // Added this field
    this.offerStartDate,
    this.offerEndDate,
    this.offerStatus,
    this.offerTypeName,
    this.amountToBuy,
    this.amountToGet,
    this.percent,
    this.quantityOfProduct, // Fixed typo
  }) : super(
          offerId: id ?? 0,
          offerTitle: offerName ?? '',
          typeName: offerTypeName ?? '',
          isActive: offerStatus ?? false,
          startOffer: offerStartDate ?? DateTime.now(),
          endOffer: offerEndDate ?? DateTime.now(),
          countProducts: quantityOfProduct ?? 0, // Fixed typo
          numberToBuy: amountToBuy ?? 0,
          numberToGet: amountToGet ?? 0,
          discountRate: percent ?? 0,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json['id'] as int?,
        offerName: json['offerName'] as String?,
        offerDesc: json['offerDesc'] as String?, // Added this field
        offerStartDate: json['offerStartDate'] == null
            ? null
            : DateTime.parse(json['offerStartDate'] as String),
        offerEndDate: json['offerEndDate'] == null
            ? null
            : DateTime.parse(json['offerEndDate'] as String),
        offerStatus: json['offerStatus'] as bool?,
        offerTypeName: json['offerTypeName'] as String?,
        amountToBuy: json['amountToBuy'] as int?, // Changed to int
        amountToGet: json['amountToGet'] as int?, // Changed to int
        percent: (json['percent'] as num?)?.toDouble(), // Changed to double
        quantityOfProduct: json['quntityOfProduct'] as int?, // Fixed typo
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'offerName': offerName,
        'offerDesc': offerDesc, // Added this field
        'offerStartDate': offerStartDate?.toIso8601String(),
        'offerEndDate': offerEndDate?.toIso8601String(),
        'offerStatus': offerStatus,
        'offerTypeName': offerTypeName,
        'amountToBuy': amountToBuy,
        'amountToGet': amountToGet,
        'percent': percent,
        'quntityOfProduct': quantityOfProduct, // Fixed typo
      };
}
