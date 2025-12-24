import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Use case for logging out the user
class LogoutUseCase {
  final FlutterSecureStorage storage;

  LogoutUseCase(this.storage);

  Future<Either<DataFailed, DataSuccess<void>>> execute() async {
    try {
      //yuou should delete all local storage data, when user applay to log out
      // and when there are new user login in, there data should not be combned
      //combined data of old user and new user
      await storage.delete(key: 'token');
      await storage.delete(key: 'pay');
      await storage.delete(key: 'darkMode');
      await storage.delete(key: 'language');
      await storage.deleteAll();
      return Right(DataSuccess(null));
    } catch (e) {
      return Left(DataFailed("Failed to logout: ${e.toString()}"));
    }
  }
}
