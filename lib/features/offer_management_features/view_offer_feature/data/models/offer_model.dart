import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity {
  int? id;
  String? offerName;
  DateTime? offerStartDate;
  DateTime? offerEndDate;
  bool? offerStatus;
  String? offerTypeName;
  dynamic amountToBuy;
  dynamic amountToGet;
  dynamic percent;
  int? quntityOfProduct;

  OfferModel({
    this.id,
    this.offerName,
    this.offerStartDate,
    this.offerEndDate,
    this.offerStatus,
    this.offerTypeName,
    this.amountToBuy,
    this.amountToGet,
    this.percent,
    this.quntityOfProduct,
  }) : super(
          offerId: id ?? 0,
          offerTitle: offerName ?? '',
          typeName: offerTypeName ?? '',
          isActive: offerStatus ?? false,
          startOffer: offerStartDate ?? DateTime.now(),
          endOffer: offerEndDate ?? DateTime.now(),
          countProducts: quntityOfProduct ?? 0,
          numberToBuy: amountToBuy ?? 0,
          numberToGet: amountToGet ?? 0,
          discountRate: percent ?? 0,
        );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json['id'] as int?,
        offerName: json['offerName'] as String?,
        offerStartDate: json['offerStartDate'] == null
            ? null
            : DateTime.parse(json['offerStartDate'] as String),
        offerEndDate: json['offerEndDate'] == null
            ? null
            : DateTime.parse(json['offerEndDate'] as String),
        offerStatus: json['offerStatus'] as bool?,
        offerTypeName: json['offerTypeName'] as String?,
        amountToBuy: json['amountToBuy'] as dynamic,
        amountToGet: json['amountToGet'] as dynamic,
        percent: json['percent'] as dynamic,
        quntityOfProduct: json['quntityOfProduct'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'offerName': offerName,
        'offerStartDate': offerStartDate?.toIso8601String(),
        'offerEndDate': offerEndDate?.toIso8601String(),
        'offerStatus': offerStatus,
        'offerTypeName': offerTypeName,
        'amountToBuy': amountToBuy,
        'amountToGet': amountToGet,
        'percent': percent,
        'quntityOfProduct': quntityOfProduct,
      };
}
