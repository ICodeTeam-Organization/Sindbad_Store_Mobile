import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_paramer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';

class GetOfferDetailsUseCase
    extends UseCaseWithParam<List<OfferDetailsEntity>, OfferDetailsParams> {
  final OffersRepositoryImpl viewOfferRepo;

  GetOfferDetailsUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, List<OfferDetailsEntity>>> execute(
      OfferDetailsParams params) {
    return viewOfferRepo.getOfferDetails(
      params.pageSize,
      params.pageNumber,
      params.offerHeadId,
    );
  }
}
