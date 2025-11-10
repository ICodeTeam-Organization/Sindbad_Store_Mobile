import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/confrim_password_parans.dart';

class ConfirmPasswordUseCase extends UseCase<DataState, ConfrimPasswordParans> {
  final AuthentationRepositoryImp authRepo;

  ConfirmPasswordUseCase(this.authRepo);

  @override
  Future<Either<DataFailed, DataSuccess>> execute(
      ConfrimPasswordParans params) {
    return authRepo.confirmCode(params.phoneNumber, params.code);
  }
}
