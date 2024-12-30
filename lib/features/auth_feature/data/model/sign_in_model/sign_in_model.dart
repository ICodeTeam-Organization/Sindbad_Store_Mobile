import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

import 'data.dart';

class SignInModel extends SignInEntity {
  bool? success;
  String? message;
  List<String>? errors;
  Data? data;

  SignInModel({this.success, this.message, this.errors, this.data})
      : super(
          isSuccess: success ?? false,
          serverMessage: message ?? "",
          dataMessage: data?.message ?? "",
          isAuthenticated: data?.isAuthenticated ?? false,
          userRoles: data?.userRoles ?? [],
          token: data?.token ?? "",
          fullName: data?.fullName ?? "",
          phoneNumber: data?.phoneNumber ?? "",
          email: data?.email ?? "",
        );

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        errors: json['errors'] as List<String>?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'errors': errors,
        'data': data?.toJson(),
      };
}
