import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_products_parames.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/product_entity.dart';

class GetProductsUseCase
    extends UseCaseWithParam<List<ProductEntity>, ProductsParams> {
  final ProductRepositoryImpl productRepository;

  GetProductsUseCase(this.productRepository);
  @override
  Future<Either<Failure, List<ProductEntity>>> execute(
      ProductsParams params) async {
    // return productRepository.getProductsByFilter(
    //   storeProductsFilter: params.storeProductsFilter,
    //   pageNumber: params.pageNumber,
    //   pageSize: params.pageSize,
    //   categoryId: params.categoryId,
    // );
    return productRepository.getAllProducts(
      params.pageNumber,
      params.pageSize,
      params.categoryId,
    );
  }
}
