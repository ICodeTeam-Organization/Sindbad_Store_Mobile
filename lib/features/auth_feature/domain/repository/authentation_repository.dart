import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/reset_password_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';

abstract class AuthentationRepository {
  Future<Either<Failure, SignInEntity>> signIn(
      String phoneNumber, String password);
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(
      String currentPassword, String newPassword);
  Future<Either<DataFailed, DataState>> foregetPassword(
      String currentPassword, String newPassword);
}
