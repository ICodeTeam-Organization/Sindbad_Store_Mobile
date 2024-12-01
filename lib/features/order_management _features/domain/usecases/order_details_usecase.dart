import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/repos/all_order_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/order_detalis_entity.dart';

class OrderDetailsUsecase
    extends UseCaseWithParam<List<OrderDetailsEntity>, OrderDetailsParam> {
  final AllOrderRepo allOrderRepo;

  OrderDetailsUsecase(this.allOrderRepo);

  @override
  Future<Either<Failure, List<OrderDetailsEntity>>> execute(
      OrderDetailsParam params) async {
    return await allOrderRepo.fetchOrderDetails(
      orderId: params.orderId,
      orderNumber: params.orderNumber,
      billNumber: params.billNumber,
      clock: params.clock,
      date: params.date,
      itemNumber: params.itemNumber,
      paymentInfo: params.paymentInfo,
      orderStatus: params.orderStatus,
    );
  }
}

class OrderDetailsParam {
  final int orderId;
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  OrderDetailsParam(
      {required this.orderId,
      required this.orderNumber,
      required this.billNumber,
      required this.clock,
      required this.date,
      required this.itemNumber,
      required this.paymentInfo,
      required this.orderStatus});
}
