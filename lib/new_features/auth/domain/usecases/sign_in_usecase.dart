import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/sign_in_entity.dart';
import '../repos/sign_in_repo.dart';

class SignInUseCase extends UseCaseWithParam<SignInEntity, SignInParams> {
  final SignInRepo authRepo;

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
