import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/profie_data_source_impl.dart';

import '../../../../core/errors/failure.dart';
import '../../domin/entity/edit_profile_entity.dart';
import '../../domin/entity/get_profile_data_entity.dart';
import '../../domin/repo/profile_repository.dart';

class ProfileRepositoryImple extends ProfileRepository {
  final ProfileDataSourceImpl _profileDataSource;

  ProfileRepositoryImple(this._profileDataSource);
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
        () => _profileDataSource.editProfile(name, email, phone, telePhone));
  }

  @override
  Future<Either<Failure, GetProfileDataEntity>> getProfile() async {
    try {
      final data = await _profileDataSource.getProfileData();
      return Right(data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
