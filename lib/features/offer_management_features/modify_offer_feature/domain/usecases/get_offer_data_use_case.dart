import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/repo/new_offer_repo.dart';

class GetOfferDataUseCase
    extends UseCaseWithParam<OfferDataEntity, OfferDataParams> {
  final NewOfferRepo newOfferRepo;

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
