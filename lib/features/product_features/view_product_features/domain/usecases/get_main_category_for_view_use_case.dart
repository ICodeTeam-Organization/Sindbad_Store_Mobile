import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../entities/main_category_for_view_entity.dart';
import '../repos/view_product_store_repo.dart';

class GetMainCategoryForViewUseCase extends UseCaseWithParam<
    List<MainCategoryForViewEntity>, MainCategoryForViewParams> {
  final ViewProductRepo viewProductRepo;

  GetMainCategoryForViewUseCase(this.viewProductRepo);
  @override
  Future<Either<Failure, List<MainCategoryForViewEntity>>> execute(
      MainCategoryForViewParams params) async {
    return viewProductRepo.getMainCategoryForView(
        pageNumper: params.pageNumper, pageSize: params.pageSize);
  }
}

class MainCategoryForViewParams {
  final int pageNumper;
  final int pageSize;

  MainCategoryForViewParams({
    required this.pageNumper,
    required this.pageSize,
  });
}
