import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/profile_repository_impl.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/no_param_use_case.dart';
import '../entity/get_profile_data_entity.dart';

class GetProfileDataUsecase extends UseCaseWithNoParam {
  final ProfileRepositoryImple _profileRepository;
  GetProfileDataUsecase(this._profileRepository);
  @override
  Future<Either<Failure, GetProfileDataEntity>> execute() {
    return _profileRepository.getProfile();
  }
}
