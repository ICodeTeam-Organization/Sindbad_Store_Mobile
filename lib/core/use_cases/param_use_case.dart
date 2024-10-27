import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';

// UseCase With Parameters

abstract class UseCaseWithParam<type, params> {
  Future<Either<Failure, type>> execute(params params);
}
