import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/forget_password_params.dart';

import '../../../../core/use_cases/param_use_case.dart';

class ForgetPasswordUseCase extends UseCase<DataState, ForgetPasswordParams> {
  final AuthentationRepositoryImp authRepo;

  ForgetPasswordUseCase(this.authRepo);

  @override
  Future<Either<DataFailed, DataState>> execute(ForgetPasswordParams params) {
    // TODO: implement execute
    final responsve =
        authRepo.foregetPassword(params.phoneNumber, params.password);

    return responsve;
  }
}
