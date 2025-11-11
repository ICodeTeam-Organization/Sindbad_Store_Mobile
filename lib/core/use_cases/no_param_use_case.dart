import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
// UseCase With No Parameters

abstract class UseCaseWithNoParam<type> {
  Future<Either<Failure, type>> execute();
}
