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
    return await allOrderRepo.fetchOrderDetails(packageId: params.packageId);
  }
}

class OrderDetailsParam {
  final int packageId;

  OrderDetailsParam({required this.packageId});
}
