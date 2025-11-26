import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/repos/view_product_store_repo.dart';
import '../entities/disable_products_entity.dart';

class DisableProductsByIdsUseCase
    extends UseCaseWithParam<DisableProductsEntity, DisableProductsParams> {
  final ViewProductRepo viewProductRepo;

  DisableProductsByIdsUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, DisableProductsEntity>> execute(
      DisableProductsParams params) async {
    return viewProductRepo.disableProductsByIds(ids: params.ids);
  }
}

class DisableProductsParams {
  final List<int> ids;

  DisableProductsParams({required this.ids});
}
