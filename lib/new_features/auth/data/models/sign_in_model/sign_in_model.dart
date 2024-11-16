import '../../../domain/entities/sign_in_entity.dart';
import 'data.dart';

class SignInModel extends SignInEntity {
  bool? success;
  String? message;
  Data? data;

  SignInModel({this.success, this.message, this.data})
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
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
