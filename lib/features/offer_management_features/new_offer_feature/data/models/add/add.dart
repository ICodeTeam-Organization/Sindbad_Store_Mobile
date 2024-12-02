import 'add_offer_dto.dart';

class Add {
  String? name;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  bool? isActive;
  int? numberOfOrders;
  int? offerHeadType;
  List<AddOfferDto>? addOfferDtos;

  Add({
    this.name,
    this.description,
    this.startDate,
    this.endDate,
    this.isActive,
    this.numberOfOrders,
    this.offerHeadType,
    this.addOfferDtos,
  });

  factory Add.fromJson(Map<String, dynamic> json) => Add(
        name: json['name'] as String?,
        description: json['description'] as String?,
        startDate: json['startDate'] == null
            ? null
            : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null
            ? null
            : DateTime.parse(json['endDate'] as String),
        isActive: json['isActive'] as bool?,
        numberOfOrders: json['numberOfOrders'] as int?,
        offerHeadType: json['offerHeadType'] as int?,
        addOfferDtos: (json['addOfferDtos'] as List<dynamic>?)
            ?.map((e) => AddOfferDto.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'isActive': isActive,
        'numberOfOrders': numberOfOrders,
        'offerHeadType': offerHeadType,
        'addOfferDtos': addOfferDtos?.map((e) => e.toJson()).toList(),
      };
}
