import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/edit_product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/edit_product_from_store_params.dart';

class EditProductUseCase
    extends UseCaseWithParam<EditProductEntity, EditProductFromStoreParams> {
  final ProductRepositoryImpl productRepository;

  EditProductUseCase(this.productRepository);
  @override
  Future<Either<Failure, EditProductEntity>> execute(
      EditProductFromStoreParams params) {
    return productRepository.editProductFromStore(
        params.id,
        params.description,
        params.price,
        params.mainImageFile,
        params.storeId,
        params.offerId,
        params.brandId,
        params.mainCategoryId,
        params.images,
        params.imagesUrl,
        params.subCategoryIds,
        params.newAttributes,
        params.tags,
        params.oldPrice,
        params.shortDescription);
  }
}
