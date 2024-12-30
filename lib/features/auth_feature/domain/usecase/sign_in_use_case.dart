import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/repo/auth_repo.dart';

class SignInUseCase extends UseCaseWithParam<SignInEntity, SignInParams> {
  final AuthRepo authRepo;

  SignInUseCase(this.authRepo);

  @override
  Future<Either<Failure, SignInEntity>> execute(SignInParams params) {
    return authRepo.signIn(params.phoneNumber, params.password);
  }
}

class SignInParams {
  final String phoneNumber;
  final String password;

  SignInParams(
    this.phoneNumber,
    this.password,
  );
}
