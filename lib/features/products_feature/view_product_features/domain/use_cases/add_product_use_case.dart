import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/add_products_parames.dart';
import '../../../../../core/use_cases/param_use_case.dart';
import '../../../add_and_edit_product_feature/domain/entities/add_product_entities/add_product_entity.dart';

class AddProductUseCase
    extends UseCaseWithParam<AddProductEntity, AddProductParams> {
  final ProductRepositoryImpl productRepository;

  AddProductUseCase(this.productRepository);
  @override
  Future<Either<Failure, AddProductEntity>> execute(AddProductParams params) {
    return productRepository.addProductToStore(
      name: params.name,
      price: params.price,
      description: params.description,
      mainImageFile: params.mainImageFile,
      number: params.number,
      mainCategoryId: params.mainCategoryId,
      subCategoryIds: params.subCategoryIds,
      storeId: params.storeId,
      offerId: params.offerId,
      brandId: params.brandId,
      images: params.images,
      newAttributes: params.newAttributes,
      tags: params.tags,
      oldPrice: params.oldPrice,
      shortDescription: params.shortDescription,
    );
  }
}
