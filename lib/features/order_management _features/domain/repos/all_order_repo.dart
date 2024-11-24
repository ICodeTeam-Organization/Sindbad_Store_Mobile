import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/all_order_entity.dart';

abstract class AllOrderRepo {
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder(
      {required bool isUrgen,
      required int pageNumber,
      required int pageSize,
      required int orderDetailStatus,
      required String srearchKeyword});
}
