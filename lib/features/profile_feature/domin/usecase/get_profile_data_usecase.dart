import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/no_param_use_case.dart';
import '../entity/get_profile_data_entity.dart';
import '../repo/profile_repo.dart';

class GetProfileDataUsecase extends UseCaseWithNoParam {
  final ProfileRepo profileRepo;
  GetProfileDataUsecase(this.profileRepo);
  @override
  Future<Either<Failure, GetProfileDataEntity>> execute() {
    return profileRepo.getProfile();
  }
}
