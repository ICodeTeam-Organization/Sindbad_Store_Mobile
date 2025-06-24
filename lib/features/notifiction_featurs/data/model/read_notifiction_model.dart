import '../../domin/entity/read_notificton.dart';

class ReadNotifictionModel extends ReadNotifictonEntity {
  bool? success;
  String? message;
  List<String>? errors;
  String? data;

  ReadNotifictionModel({
    this.success,
    this.message,
    this.errors,
    this.data,
  }) : super(isSuccess: success ?? false, serverMessage: message ?? '');

  factory ReadNotifictionModel.fromJson(Map<String, dynamic> json) {
    return ReadNotifictionModel(
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
