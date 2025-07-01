import '../../../domain/entity/reset_password_entity.dart';

class ResetPasswordModel extends ResetPasswordEntity {
  bool? success;
  String? message;
  List<String>? errors;
  bool? data;

  ResetPasswordModel({this.success, this.message, this.errors, this.data})
      : super(
            isSuccess: success ?? false,
            serverMessage: message ?? "",
            errorsList: errors ?? [],
            dataContent: data ?? false);

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as List<String>?,
      data: json['data'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errors': errors,
        'data': data,
      };
}
