import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/edit_product_entities/product_details_entity.dart';

class GetProductDetailsToStoreUseCase extends UseCaseWithParam<
    ProductDetailsEntity, GetProductDetailsToStoreParams> {
  final ProductRepositoryImpl productRepository;

  GetProductDetailsToStoreUseCase(this.productRepository);
  @override
  Future<Either<Failure, ProductDetailsEntity>> execute(
      GetProductDetailsToStoreParams params) async {
    return productRepository.getProductDetails(
      productId: params.productId,
    );
  }
}

class GetProductDetailsToStoreParams {
  final int productId;

  GetProductDetailsToStoreParams({
    required this.productId,
  });
}
