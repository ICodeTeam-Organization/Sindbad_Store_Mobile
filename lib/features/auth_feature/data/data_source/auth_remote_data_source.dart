import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/auth_feature/data/model/sign_in_model/sign_in_model.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

import '../../domain/entity/reset_password_entity.dart';
import '../model/reset_password_model/reset_password_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignInEntity> signIn(String phoneNumber, String password);
  Future<ResetPasswordEntity> resetPassword(
      String currentPassword, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;
  AuthRemoteDataSourceImpl(this.apiService, this.secureStorage);

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

    print(userVerification);
    return userVerification;
  }

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
}
