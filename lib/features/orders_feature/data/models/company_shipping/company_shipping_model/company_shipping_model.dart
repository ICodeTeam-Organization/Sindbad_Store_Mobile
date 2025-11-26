import 'package:sindbad_management_app/features/orders_feature/domain/entities/company_shipping_entity.dart';

class CompanyShippingModel extends CompanyShippingEntity {
  int? id;
  String? name;

  CompanyShippingModel({this.id, this.name})
      : super(comId: id ?? 0, comName: name ?? '');

  factory CompanyShippingModel.fromJson(Map<String, dynamic> json) {
    return CompanyShippingModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
