import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/edit_product_entities/product_details_entity.dart';
import '../repos/add_and_edit_product_store_repo.dart';

class GetProductDetailsToStoreUseCase extends UseCaseWithParam<
    ProductDetailsEntity, GetProductDetailsToStoreParams> {
  final AddAndEditProductStoreRepo addAndEditProductStoreRepo;

  GetProductDetailsToStoreUseCase(this.addAndEditProductStoreRepo);
  @override
  Future<Either<Failure, ProductDetailsEntity>> execute(
      GetProductDetailsToStoreParams params) async {
    return addAndEditProductStoreRepo.getProductDetails(
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
