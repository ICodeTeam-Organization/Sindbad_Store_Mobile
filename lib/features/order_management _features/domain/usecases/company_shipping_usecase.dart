import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/repos/all_order_repo.dart';
import '../../../../core/errors/failure.dart';

class CompanyShippingUsecase extends UseCaseWithParam<
    List<CompanyShippingEntity>, CompanyShippingParam> {
  final AllOrderRepo allOrderRepo;

  CompanyShippingUsecase({required this.allOrderRepo});
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
