import '../../domin/entity/edit_profile_entity.dart';

class UpdateProfielModel extends EditProfileEntity {
  bool? success;
  String? message;
  List<String>? errors;
  String? data;

  UpdateProfielModel({this.success, this.message, this.errors, this.data})
      : super(
          isSuccess: success ?? false,
          serverMessage: message ?? '',
        );

  factory UpdateProfielModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfielModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as List<String>?,
      data: json['data'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errors': errors,
        'data': data,
      };
}
