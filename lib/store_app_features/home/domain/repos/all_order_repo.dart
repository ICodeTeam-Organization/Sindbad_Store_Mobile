import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/store_app_features/home/domain/entities/all_order_entity.dart';

abstract class AllOrderRepo {
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder(
      {required int pageNumber,
      required int pageSize,
      required String storeId,
      required int srearchKeyword});
}
