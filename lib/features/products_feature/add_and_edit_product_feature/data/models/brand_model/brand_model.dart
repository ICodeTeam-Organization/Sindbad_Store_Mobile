import 'datum.dart';

class BrandModel {
  bool? success;
  String? message;
  List<Datum>? data; // datum لأن فيه كلاس ثاني بنفس اسم داتا

  BrandModel({this.success, this.message, this.data});

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
