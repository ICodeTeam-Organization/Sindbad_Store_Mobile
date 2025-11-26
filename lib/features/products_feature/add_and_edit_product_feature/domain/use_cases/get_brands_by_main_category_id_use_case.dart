import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/repos/add_and_edit_product_store_repo.dart';

import '../entities/add_product_entities/brand_entity.dart';

class GetBrandsByMainCategoryIdUseCase extends UseCaseWithParam<
    List<BrandEntity>, GetBrandsByMainCategoryIdParams> {
  final AddAndEditProductStoreRepo addProductStoreRepo;

  GetBrandsByMainCategoryIdUseCase(this.addProductStoreRepo);
  @override
  Future<Either<Failure, List<BrandEntity>>> execute(
      GetBrandsByMainCategoryIdParams params) {
    return addProductStoreRepo.getBrandsByMainCategoryId(
        mainCategoryId: params.mainCategoryId);
  }
}

class GetBrandsByMainCategoryIdParams {
  final int? mainCategoryId;

  GetBrandsByMainCategoryIdParams({
    required this.mainCategoryId,
  });
}
