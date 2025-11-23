import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';

// UseCase With Parameters

abstract class UseCaseWithParam<type, params> {
  Future<Either<Failure, type>> execute(params params);
}

abstract class UseCase<type, params> {
  Future<Either<DataFailed, DataState>> execute(params params);
}

abstract class MyUseCase<SuccessType, Params> {
  Future<Either<DataFailed, DataSuccess<SuccessType>>> call({Params params});
}
