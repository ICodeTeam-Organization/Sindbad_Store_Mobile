import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/orders_feature/data/repos_impl/all_order_repo_impl.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/all_order_entity.dart';
import '../repos/all_order_repo.dart';

class NewOrderUsecase
    extends UseCaseWithParam<List<AllOrderEntity>, AllOrderParam> {
  final AllOrderRepoImpl allOrderRepo;

  NewOrderUsecase(this.allOrderRepo);
  @override
  Future<Either<Failure, List<AllOrderEntity>>> execute(
      AllOrderParam params) async {
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

class AllOrderParam {
  final List<int> statuses;
  final bool? isUrgent;
  final int pageNumber;
  final int pageSize;
  // final String storeId;
  // final String srearchKeyword;

  AllOrderParam({
    required this.statuses,
    this.isUrgent,
    required this.pageNumber,
    required this.pageSize,
    // required this.storeId,
    // required this.srearchKeyword,
  });
}
