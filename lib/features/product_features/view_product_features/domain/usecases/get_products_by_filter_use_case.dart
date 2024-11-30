import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/product_entity.dart';
import '../repos/view_product_store_repo.dart';

class GetProductsByFilterUseCase
    extends UseCaseWithParam<List<ProductEntity>, ProductsByFilterParams> {
  final ViewProductRepo viewProductRepo;

  GetProductsByFilterUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, List<ProductEntity>>> execute(
      ProductsByFilterParams params) async {
    return viewProductRepo.getProductsByFilter(
      storeProductsFilter: params.storeProductsFilter,
      pageNumper: params.pageNumper,
      pageSize: params.pageSize,
    );
  }
}

class ProductsByFilterParams {
  final int storeProductsFilter;
  final int pageNumper;
  final int pageSize;

  ProductsByFilterParams(
    this.storeProductsFilter,
    this.pageNumper,
    this.pageSize,
  );
}
