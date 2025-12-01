import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

import '../../../../core/errors/failure.dart';
import '../entity/edit_profile_entity.dart';
import '../entity/get_profile_data_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, EditProfileEntity>> editProfile(
      String name, String email, String phone, String telePhone);
  Future<Either<Failure, GetProfileDataEntity>> getProfile();
}
