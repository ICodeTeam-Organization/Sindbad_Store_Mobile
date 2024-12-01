import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/all_order_entity.dart';

abstract class AllOrderRepo {
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder(
      {required bool isUrgen,
      int pageNumber = 1,
      required int pageSize,
      required int orderDetailStatus,
      required String srearchKeyword});
}
