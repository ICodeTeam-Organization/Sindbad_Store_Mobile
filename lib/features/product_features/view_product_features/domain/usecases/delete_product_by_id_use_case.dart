import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/delete_entity_product.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../repos/view_product_store_repo.dart';

class DeleteProductByIdUseCase
    extends UseCaseWithParam<DeleteProductEntity, DeleteProductByIdPara> {
  final ViewProductRepo viewProductRepo;

  DeleteProductByIdUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, DeleteProductEntity>> execute(
      DeleteProductByIdPara params) async {
    return viewProductRepo.deleteProductById(productId: params.productId);
  }
}

class DeleteProductByIdPara {
  final int productId;

  DeleteProductByIdPara(
    this.productId,
  );
}
