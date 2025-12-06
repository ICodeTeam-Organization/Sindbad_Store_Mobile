import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/reset_password_params.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entity/reset_password_entity.dart';

class ResetPasswordUseCase
    extends UseCaseWithParam<ResetPasswordEntity, ResetPasswordParams> {
  final AuthentationRepositoryImp authRepo;

  ResetPasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, ResetPasswordEntity>> execute(
      ResetPasswordParams params) {
    return authRepo.resetPassword(params.currentPassword, params.newPassword);
  }
}
