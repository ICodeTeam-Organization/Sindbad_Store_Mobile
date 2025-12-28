import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/repos/view_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_params.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';

class GetOffersUseCase
    extends UseCaseWithParam<List<OfferEntity>, OfferParams> {
  final OffersRepositoryImpl offersRepository;

  GetOffersUseCase(this.offersRepository);

  @override
  Future<Either<Failure, List<OfferEntity>>> execute(OfferParams params) {
    return offersRepository.getOffers(
      params.pageSize,
      params.pageNumber,
    );
  }
}
