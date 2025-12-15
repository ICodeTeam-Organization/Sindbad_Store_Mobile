import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/orders_feature/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/company_shipping_entity.dart';
import '../../../../core/errors/failure.dart';

class CompanyShippingUsecase extends UseCaseWithParam<
    List<CompanyShippingEntity>, CompanyShippingParam> {
  final AllOrderRepoImpl allOrderRepo;

  CompanyShippingUsecase(this.allOrderRepo);
  @override
  Future<Either<Failure, List<CompanyShippingEntity>>> execute(
      CompanyShippingParam params) async {
    return await allOrderRepo.fetchCompanyShipping(
        pageNumber: params.pageNumber, pageSize: params.pageSize);
  }
}

class CompanyShippingParam {
  final int pageNumber;
  final int pageSize;

  CompanyShippingParam({
    required this.pageNumber,
    required this.pageSize,
  });
}
