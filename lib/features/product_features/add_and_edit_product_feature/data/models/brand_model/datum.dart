import '../../../domain/entities/brand_entity.dart';

class Datum extends BrandEntity {
  // datum لأن فيه كلاس ثاني بنفس اسم داتا
  int? id;
  String? name;

  Datum({this.id, this.name})
      : super(brandId: id ?? 000, brandNameEntity: name ?? 'لا يوجد');

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
