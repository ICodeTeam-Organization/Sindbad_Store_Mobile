import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/data/repos/view_product_store_repo_impl.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/product_entity.dart';
import '../repos/view_product_store_repo.dart';

class GetProductsByFilterUseCase
    extends UseCaseWithParam<List<ProductEntity>, ProductsByFilterParams> {
  final ViewProductRepoImpl viewProductRepo;

  GetProductsByFilterUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, List<ProductEntity>>> execute(
      ProductsByFilterParams params) async {
    return viewProductRepo.getProductsByFilter(
      storeProductsFilter: params.storeProductsFilter,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
      categoryId: params.categoryId,
    );
  }
}

class ProductsByFilterParams {
  final int storeProductsFilter;
  final int pageNumber;
  final int pageSize;
  final int? categoryId;

  ProductsByFilterParams(
    this.storeProductsFilter,
    this.pageNumber,
    this.pageSize,
    this.categoryId,
  );
}
