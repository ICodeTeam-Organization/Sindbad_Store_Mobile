import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/core/models/Responsice_Error.dart';
import 'package:sindbad_management_app/core/models/responsive_model.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:sindbad_management_app/features/auth_feature/data/model/reset_password_model.dart';
import 'package:sindbad_management_app/features/auth_feature/data/model/sign_in_model.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/reset_password_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final ApiService apiService = ApiService();
  final Dio _dio = Dio();

  // final FlutterSecureStorage secureStorage;
  AuthRemoteDataSourceImpl();
  //getit.get<ApiService>(),
  // get Token Function
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  @override
  Future<SignInEntity> signIn(String phoneNumber, String password) async {
    var data = await apiService.post(
      endPoint: "Auth/Login",
      data: {
        'password': password,
        'phoneNumber': phoneNumber,
      },
    );

    SignInEntity userVerification = SignInModel.fromJson(data);

    if (userVerification.isSuccess == true && userVerification.token != null) {
      await secureStorage.write(key: 'token', value: userVerification.token);
    }

    debugPrint(userVerification.toString());
    return userVerification;
  }

  @override
  Future<ResetPasswordEntity> resetPassword(
      String currentPassword, String newPassword) async {
    String? token = await getToken();

    var data = await apiService.put(endPoint: "Auth/ChangePassword", data: {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    }, headers: {
      'Authorization': 'Bearer $token',
    });
    ResetPasswordEntity userPassword = ResetPasswordModel.fromJson(data);
    return userPassword;
  }

  @override
  Future<ResponseModel> foregetPassword(
      String phoneNumber, String newPassword) async {
    final response = await _dio.post(
      "https://www.sindibad-back.com:82/api/Auth/ResetPassword",
      data: {
        'phoneNumber': phoneNumber,
        'newPassword': newPassword,
      },
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(response.data);
    }

    // Validation or known error
    if (response.statusCode == 400 || response.statusCode == 422) {
      throw ResponseError.fromJson(response.data);
    }

    // Server error
    if (response.statusCode != null && response.statusCode! >= 500) {
      throw ResponseError(
        message: "Server error, please try again later",
        validationErrors: {},
      );
    }

    // Unknown error
    throw ResponseError(
      message: "Unexpected error occurred",
      validationErrors: {},
    );
  }
}
