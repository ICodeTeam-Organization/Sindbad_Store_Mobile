import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/repos/view_product_store_repo.dart';
import '../entities/activate_products_entity.dart';

class ActivateProductsByIdsUseCase
    extends UseCaseWithParam<ActivateProductsEntity, ActivateProductsParams> {
  final ViewProductRepo viewProductRepo;

  ActivateProductsByIdsUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, ActivateProductsEntity>> execute(
      ActivateProductsParams params) async {
    return viewProductRepo.activateProductsByIds(ids: params.ids);
  }
}

class ActivateProductsParams {
  final List<int> ids;

  ActivateProductsParams({required this.ids});
}
