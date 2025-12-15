import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';

class GetOfferDataUseCase
    extends UseCaseWithParam<OfferDataEntity, OfferDataParams> {
  final NewOfferRepositoryImpl newOfferRepo;

  GetOfferDataUseCase(this.newOfferRepo);

  @override
  Future<Either<Failure, OfferDataEntity>> execute(OfferDataParams params) {
    return newOfferRepo.getOfferData(
      params.offerHeadId,
    );
  }
}

class OfferDataParams {
  final int offerHeadId;

  OfferDataParams(
    this.offerHeadId,
  );
}
