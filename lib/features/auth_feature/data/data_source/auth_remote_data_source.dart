import 'package:sindbad_management_app/core/models/responsive_model.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

import '../../domain/entity/reset_password_entity.dart';

abstract class AuthRemoteDataSource {
  Future<SignInEntity> signIn(String phoneNumber, String password);
  Future<ResetPasswordEntity> resetPassword(
      String currentPassword, String newPassword);
  Future<ResponseModel> foregetPassword(String phoneNumber, String newPassword);
  Future<ResponseModel> confirmCode(String phoneNumber, String code);
}
