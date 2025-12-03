import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/repos/product_store_repository.dart';
import '../entities/disable_products_entity.dart';

class DisableProductsUseCase
    extends UseCaseWithParam<DisableProductsEntity, List<int>> {
  final ProductRepositoryImpl productRepository;

  DisableProductsUseCase(this.productRepository);
  @override
  Future<Either<Failure, DisableProductsEntity>> execute(
      List<int> productsIds) async {
    return productRepository.disableProductsByIds(productsIds);
  }
}
