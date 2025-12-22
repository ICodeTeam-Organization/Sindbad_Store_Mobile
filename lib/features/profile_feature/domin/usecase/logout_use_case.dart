import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Use case for logging out the user
class LogoutUseCase {
  final FlutterSecureStorage storage;

  LogoutUseCase(this.storage);

  Future<Either<DataFailed, DataSuccess<void>>> execute() async {
    try {
      await storage.delete(key: 'token');
      return Right(DataSuccess(null));
    } catch (e) {
      return Left(DataFailed("Failed to logout: ${e.toString()}"));
    }
  }
}
