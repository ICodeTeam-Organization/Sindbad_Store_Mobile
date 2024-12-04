import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/repos/all_order_repo.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/order_cancel_entity.dart';

class OrderCancelUsecase
    extends UseCaseWithParam<OrderCancelEntity, OrderCancelParam> {
  final AllOrderRepo allOrderRepo;
  OrderCancelUsecase({required this.allOrderRepo});

  @override
  Future<Either<Failure, OrderCancelEntity>> execute(
      OrderCancelParam params) async {
    return await allOrderRepo.fetchOrderCancel(
      orderId: params.orderId,
      orderCancel: params.orderCancel,
      reasonCancel: params.reasonCancel,
    );
  }
}

class OrderCancelParam {
  final int orderId;
  final bool orderCancel;
  final String reasonCancel;

  OrderCancelParam({
    required this.orderId,
    required this.orderCancel,
    required this.reasonCancel,
  });
}
