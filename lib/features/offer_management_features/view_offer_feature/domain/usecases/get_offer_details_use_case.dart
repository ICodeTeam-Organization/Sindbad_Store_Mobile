import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class GetOfferDetailsUseCase
    extends UseCaseWithParam<List<OfferDetailsEntity>, OfferDetailsParams> {
  final ViewOfferRepo viewOfferRepo;

  GetOfferDetailsUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, List<OfferDetailsEntity>>> execute(
      OfferDetailsParams params) {
    return viewOfferRepo.getOfferDetails(params.offerId);
  }
}

class OfferDetailsParams {
  final int offerId;

  OfferDetailsParams(this.offerId);
}
