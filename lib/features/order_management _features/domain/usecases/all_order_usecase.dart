import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../entities/all_order_entity.dart';
import '../repos/all_order_repo.dart';

class AllOrderUsecase
    extends UseCaseWithParam<List<AllOrderEntity>, AllOrderParam> {
  final AllOrderRepo allOrderRepo;

  AllOrderUsecase(this.allOrderRepo);

  @override
  Future<Either<Failure, List<AllOrderEntity>>> execute(
      AllOrderParam params) async {
    return await allOrderRepo.fetchAllOrder(
        isUrgen: params.isUrgen,
        orderDetailStatus: params.orderDetailStatus,
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
        srearchKeyword: params.srearchKeyword);
  }
}

class AllOrderParam {
  final bool isUrgen;
  final int orderDetailStatus;
  final int pageSize;
  final int pageNumber;
  final String srearchKeyword;

  AllOrderParam(this.pageNumber, this.pageSize, this.orderDetailStatus,
      this.srearchKeyword, this.isUrgen);
}
