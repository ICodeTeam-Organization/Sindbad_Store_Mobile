import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/get_main_category_paramers.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../repos/product_store_repository.dart';

class GetMainCategoryUseCase
    extends UseCaseWithParam<List<StoreCategoryModel>, MainCategoryParams> {
  final ProductRepositoryImpl productRepository;
  // final ProductRepository productRepository;

  GetMainCategoryUseCase(this.productRepository);
  @override
  Future<Either<Failure, List<StoreCategoryModel>>> execute(
      MainCategoryParams params) async {
    return productRepository.getCategories(
      params.pageNumber,
      params.pageSize,
    );
  }
}
