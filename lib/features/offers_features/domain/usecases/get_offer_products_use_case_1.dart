import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';

class GetOfferProductsUseCase
    extends UseCaseWithParam<List<OfferProductsEntity>, OfferProductsParams> {
  final NewOfferRepositoryImpl newOfferRepo;

  GetOfferProductsUseCase(this.newOfferRepo);

  @override
  Future<Either<Failure, List<OfferProductsEntity>>> execute(
      OfferProductsParams params) {
    return newOfferRepo.getOfferProducts(
      params.pageSize,
      params.pageNumber,
    );
  }
}

class OfferProductsParams {
  final int pageSize;
  final int pageNumber;
  OfferProductsParams(
    this.pageSize,
    this.pageNumber,
  );
}
