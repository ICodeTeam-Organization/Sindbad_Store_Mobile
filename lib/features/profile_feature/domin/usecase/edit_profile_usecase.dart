import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entity/edit_profile_entity.dart';
import '../repo/profile_repo.dart';

class EditProfileUsecase
    extends UseCaseWithParam<EditProfileEntity, UpdateProfileParams> {
  final ProfileRepo profileRepo;

  EditProfileUsecase({required this.profileRepo});
  @override
  Future<Either<Failure, EditProfileEntity>> execute(
      UpdateProfileParams params) {
    return profileRepo.editProfile(
        params.name, params.email, params.phone, params.telphon);
  }
}

class UpdateProfileParams {
  String name;
  String email;
  String phone;
  String telphon;
  UpdateProfileParams(
      {required this.name,
      required this.email,
      required this.phone,
      required this.telphon});
}
