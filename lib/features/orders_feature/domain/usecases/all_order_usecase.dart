import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/orders_feature/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_param.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/all_order_entity.dart';

class NewOrderUsecase extends UseCaseWithParam<List<OrderEntity>, OrderParam> {
  final AllOrderRepoImpl allOrderRepo;

  NewOrderUsecase(this.allOrderRepo);
  @override
  Future<Either<Failure, List<OrderEntity>>> execute(OrderParam params) async {
    return await allOrderRepo.fetchAllOrder(
      statuses: params.statuses,
      isUrgent: params.isUrgent,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      // storeId: params.storeId
      // searchKeyword: params.srearchKeyword
    );
  }
}
