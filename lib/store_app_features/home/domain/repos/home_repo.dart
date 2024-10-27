import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/store_app_features/home/domain/entities/home_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<HomeEntity>>> fetchAllOrders(
      {required int pageNumber,
      required int pageSize,
      required String storeId,
      required int srearchKeyword});
}
