import 'package:sindbad_management_app/features/offers_feature/modify_offer_feature/domain/entities/offer_data_entity.dart';

import 'offer_head_offer.dart';

class OfferDataModel extends OfferDataEntity {
  bool? justActiveAndDis;
  int? id;
  String? name;
  dynamic description;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  int? numberOfOrders;
  int? offerHeadType;
  List<OfferHeadOffer>? offerHeadOffers;

  OfferDataModel({
    this.justActiveAndDis,
    this.id,
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.isActive,
    this.numberOfOrders,
    this.offerHeadType,
    this.offerHeadOffers,
  }) : super(
          offerId: id ?? 0,
          offerTitle: name ?? '',
          offerType: offerHeadType ?? 0,
          startOffer: startDate ?? DateTime.now(),
          endOffer: endDate ?? DateTime.now(),
          numberToBuy: offerHeadOffers![0].amountToBuy ?? 0,
          numberToGet: offerHeadOffers[0].amountToGet ?? 0,
          discountRate: offerHeadOffers[0].percentage ?? 0,
          listProduct: offerHeadOffers,
        );

  factory OfferDataModel.fromJson(Map<String, dynamic> json) {
    return OfferDataModel(
      justActiveAndDis: json['justActiveAndDis'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as dynamic,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool?,
      numberOfOrders: json['numberOfOrders'] as int?,
      offerHeadType: json['offerHeadType'] as int?,
      offerHeadOffers: (json['offerHeadOffers'] as List<dynamic>?)
          ?.map((e) => OfferHeadOffer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'justActiveAndDis': justActiveAndDis,
        'id': id,
        'name': name,
        'description': description,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'isActive': isActive,
        'numberOfOrders': numberOfOrders,
        'offerHeadType': offerHeadType,
        'offerHeadOffers': offerHeadOffers?.map((e) => e.toJson()).toList(),
      };
}
