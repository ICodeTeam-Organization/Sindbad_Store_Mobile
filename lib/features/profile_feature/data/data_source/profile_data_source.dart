import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/profile_model/profile_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

import '../../../../core/services/api_service.dart';
import '../../domin/entity/edit_profile_entity.dart';
import '../../domin/entity/get_profile_data_entity.dart';
import '../model/update_profiel_model.dart';

abstract class ProfileDataSource {
  Future<EditProfileEntity> editProfile(
      String name, String email, String phone, String telePhone);
  Future<GetProfileDataEntity> getProfileData();
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory();
}
