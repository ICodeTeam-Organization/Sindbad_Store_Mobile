import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/sign_in_entity.dart';

abstract class SignInRepo {
  Future<Either<Failure, SignInEntity>> signIn(
      String phoneNumber, String password);
}
