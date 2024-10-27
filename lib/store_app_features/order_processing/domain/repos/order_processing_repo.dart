import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';

import '../entities/order_processing_entity.dart';

abstract class OrderProcessingRepo {
  Future<Either<Failure, List<OrderProcessingEntity>>> fetchOrderProcessing(
      {required String storeId, required int orderId});
}
