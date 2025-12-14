import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/models/responsive_model.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/repository/authentation_repository.dart';

import '../../domain/entity/reset_password_entity.dart';

class AuthentationRepositoryImp extends AuthentationRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthentationRepositoryImp(this.authRemoteDataSource);

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
    return postData(() => authRemoteDataSource.signIn(phoneNumber, password));
  }

  @override
  Future<Either<Failure, ResetPasswordEntity>> resetPassword(
      String currentPassword, String newPassword) async {
    return postData(
        () => authRemoteDataSource.resetPassword(currentPassword, newPassword));
  }

  @override
  Future<Either<DataFailed, DataSuccess>> foregetPassword(
      String phoneNumber, String newPassword) async {
    try {
      ResponseModel response =
          await authRemoteDataSource.foregetPassword(phoneNumber, newPassword);
      if (response.message.isNotEmpty) {
        debugPrint("Reset Password Message: ${response.message}");
        return Right(DataSuccess(response.message));
      }
      return Right(DataSuccess(response));
    } catch (e) {
      return Left(DataFailed<String>(e.toString()));
    }
  }

  @override
  Future<Either<DataFailed, DataSuccess>> confirmCode(
      String phoneNumber, String code) async {
    try {
      ResponseModel response =
          await authRemoteDataSource.confirmCode(phoneNumber, code);
      if (response.message.isNotEmpty) {
        debugPrint("Code Password Message: ${response.message}");
      }

      return Right(DataSuccess<ResponseModel>(response));
    } catch (e) {
      return Left(DataFailed(e));
    }
  }
}
