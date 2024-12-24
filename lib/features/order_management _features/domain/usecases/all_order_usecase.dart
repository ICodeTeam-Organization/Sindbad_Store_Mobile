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
        canceled: params.canceled,
        delevred: params.delevred,
        noInvoice: params.noInvoice,
        unpaied: params.unpaied,
        paied: params.paied,
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
        storeId: params.storeId
        // searchKeyword: params.srearchKeyword
        );
  }
}

class AllOrderParam {
  final bool isUrgen;
  final bool canceled;
  final bool delevred;
  final bool noInvoice;
  final bool unpaied;
  final bool paied;
  final int pageNumber;
  final int pageSize;
  final String storeId;
  // final String srearchKeyword;

  AllOrderParam({
    required this.isUrgen,
    required this.canceled,
    required this.delevred,
    required this.noInvoice,
    required this.unpaied,
    required this.paied,
    required this.pageNumber,
    required this.pageSize,
    required this.storeId,
    // required this.srearchKeyword,
  });
}
