import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/new_features/auth/domain/repos/sign_in_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/sign_in_entity.dart';
import '../data_sources/sign_in_remot_data_source.dart';

class SignInRepoImpl extends SignInRepo {
  final SignInRemotDataSource signInRemotDataSource;

  SignInRepoImpl({required this.signInRemotDataSource});

// Generic PostData function
  Future<Either<Failure, T>> postData<T>(
      Future<T> Function() postDataFunction) async {
    try {
      var dataPosted = await postDataFunction();
      return right(dataPosted);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, SignInEntity>> signIn(
      String phoneNumber, String password) async {
    return postData(() => signInRemotDataSource.signIn(phoneNumber, password));
  }
}
