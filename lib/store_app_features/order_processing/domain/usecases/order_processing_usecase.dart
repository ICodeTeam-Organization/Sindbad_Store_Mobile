import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/domain/entities/order_processing_entity.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/domain/repos/order_processing_repo.dart';

class OrderProcessingUsecase extends UseCaseWithParam<
    List<OrderProcessingEntity>, OrderProcessingParam> {
  final OrderProcessingRepo orderProcessingRepo;

  OrderProcessingUsecase(this.orderProcessingRepo);

  @override
  Future<Either<Failure, List<OrderProcessingEntity>>> execute(
      OrderProcessingParam params) async {
    return await orderProcessingRepo.fetchOrderProcessing(
        storeId: params.storeId, orderId: params.orderId);
  }
}

class OrderProcessingParam {
  final String storeId;
  final int orderId;

  OrderProcessingParam(this.storeId, this.orderId);
}
