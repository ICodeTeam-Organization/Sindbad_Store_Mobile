import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

import '../../../../core/errors/failure.dart';
import '../../domin/entity/edit_profile_entity.dart';
import '../../domin/entity/get_profile_data_entity.dart';
import '../../domin/repo/profile_repository.dart';
import '../data_source/profile_data_source.dart';

class ProfileRepositoryImple extends ProfileRepository {
  final ProfileDataSourceImpl profileDataSource;

  ProfileRepositoryImple(this.profileDataSource);
  Future<Either<Failure, T>> fetchData<T>(
      Future<T> Function() fetchFunction) async {
    try {
      var data = await fetchFunction();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, EditProfileEntity>> editProfile(
      String name, String email, String phone, String telePhone) {
    return fetchData(
        () => profileDataSource.editProfile(name, email, phone, telePhone));
  }

  @override
  Future<Either<Failure, GetProfileDataEntity>> getProfile() {
    return fetchData(() => profileDataSource.getProfileData());
  }
}
