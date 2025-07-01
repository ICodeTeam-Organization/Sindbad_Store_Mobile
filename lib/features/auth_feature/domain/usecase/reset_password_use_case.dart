import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entity/reset_password_entity.dart';
import '../repo/auth_repo.dart';

class ResetPasswordUseCase
    extends UseCaseWithParam<ResetPasswordEntity, ResetPasswordParams> {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  @override
  Future<Either<Failure, ResetPasswordEntity>> execute(
      ResetPasswordParams params) {
    return authRepo.resetPassword(params.currentPassword, params.newPassword);
  }
}

class ResetPasswordParams {
  final String currentPassword;
  final String newPassword;

  ResetPasswordParams(
    this.currentPassword,
    this.newPassword,
  );
}
