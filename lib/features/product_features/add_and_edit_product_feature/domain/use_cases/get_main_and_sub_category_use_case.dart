import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../repos/add_and_edit_product_store_repo.dart';

class GetMainAndSubCategoryUseCase extends UseCaseWithParam<
    List<CategoryEntity>, GetMainAndSubCategoryParams> {
  final AddAndEditProductStoreRepo addProductStoreRepo;

  GetMainAndSubCategoryUseCase(this.addProductStoreRepo);
  @override
  Future<Either<Failure, List<CategoryEntity>>> execute(
      GetMainAndSubCategoryParams params) async {
    return addProductStoreRepo.getMainAndSubCategory(
      filterType: params.filterType,
      pageNumber: params.pageNumber,
      pageSize: params.pageSize,
    );
  }
}

class GetMainAndSubCategoryParams {
  final int filterType;
  final int pageNumber;
  final int pageSize;

  GetMainAndSubCategoryParams({
    required this.filterType,
    required this.pageNumber,
    required this.pageSize,
  });
}
