import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/singin_params.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/repository/authentation_repository.dart';

class SignInUseCase extends UseCaseWithParam<SignInEntity, SignInParams> {
  final AuthentationRepositoryImp _authentationRepository;

  SignInUseCase(this._authentationRepository);

  @override
  Future<Either<Failure, SignInEntity>> execute(SignInParams params) {
    return _authentationRepository.signIn(params.phoneNumber, params.password);
  }
}
