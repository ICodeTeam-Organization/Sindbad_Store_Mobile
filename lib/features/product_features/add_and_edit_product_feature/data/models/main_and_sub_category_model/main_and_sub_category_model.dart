import 'data.dart';

class MainAndSubCategoryModel {
  bool? success;
  String? message;
  Data? data;

  MainAndSubCategoryModel({this.success, this.message, this.data});

  factory MainAndSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return MainAndSubCategoryModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
