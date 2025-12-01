import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/profile_model/profile_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

import '../../../../core/api_service.dart';
import '../../domin/entity/edit_profile_entity.dart';
import '../../domin/entity/get_profile_data_entity.dart';
import '../model/update_profiel_model.dart';

abstract class ProfileDataSource {
  Future<EditProfileEntity> editProfile(
      String name, String email, String phone, String telePhone);
  Future<GetProfileDataEntity> getProfileData();
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final ApiService apiService;

  ProfileDataSourceImpl(this.apiService);
  @override
  Future<EditProfileEntity> editProfile(
      String name, String email, String phone, String telePhone) async {
    String? token = await secureStorage.read(key: 'token');
    var data = await apiService.put(
        data: {'name': name, 'email': email, 'telePhone': telePhone},
        endPoint: 'Customer/profile',
        headers: {'Authorization': 'Bearer $token'});
    return UpdateProfielModel.fromJson(data);
  }

  @override
  Future<GetProfileDataEntity> getProfileData() async {
    String? token = await secureStorage.read(key: 'token');
    var data = await apiService
        .get(endPoint: 'Stores', headers: {'Authorization': 'Bearer $token'});
    GetProfileDataEntity profileData =
        ProfileModel.fromJson(data['data']['items'][0]);
    return profileData;
  }

  @override
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory() {
    // TODO: implement getStoreCategory
    throw UnimplementedError();
  }
}
