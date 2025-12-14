import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../../core/use_cases/param_use_case.dart';

class GetMainAndSubCategoryUseCase
    extends UseCaseWithParam<List<CategoryEntity>, String?> {
  final AddAndEditProductStoreRepoImpl addProductStoreRepo;

  GetMainAndSubCategoryUseCase(this.addProductStoreRepo);
  @override
  Future<Either<Failure, List<CategoryEntity>>> execute(String? params) async {
    return addProductStoreRepo.getMainAndSubCategory(params);
  }
}

// class GetMainAndSubCategoryParams {
//   GetMainAndSubCategoryParams();
// }
