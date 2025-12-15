import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';

class GetOfferProductsUseCase
    extends UseCaseWithParam<List<OfferProductsEntity>, OfferProductsParams> {
  final OffersRepositoryImpl offersRepository;

  GetOfferProductsUseCase(this.offersRepository);

  @override
  Future<Either<Failure, List<OfferProductsEntity>>> execute(
      OfferProductsParams params) {
    return offersRepository.getOfferProducts(
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
