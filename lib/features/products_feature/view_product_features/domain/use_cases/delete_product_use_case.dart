import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/delete_entity_product.dart';
import '../repos/product_store_repository.dart';

class DeleteProductUseCase extends UseCaseWithParam<DeleteProductEntity, int> {
  final ProductRepositoryImpl productRepository;

  DeleteProductUseCase(this.productRepository);
  @override
  Future<Either<Failure, DeleteProductEntity>> execute(int params) async {
    return productRepository.deleteProductById(params);
  }
}
