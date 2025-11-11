import 'data.dart';

class MainCategoryForViewModel {
  bool? success;
  String? message;
  Data? data;

  MainCategoryForViewModel({this.success, this.message, this.data});

  factory MainCategoryForViewModel.fromJson(Map<String, dynamic> json) {
    return MainCategoryForViewModel(
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
