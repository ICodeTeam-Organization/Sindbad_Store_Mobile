import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/change_status_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class ChangeStatusOfferUseCase
    extends UseCaseWithParam<ChangeStatusOfferEntity, ChangeStatusOfferParams> {
  final ViewOfferRepo viewOfferRepo;

  ChangeStatusOfferUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, ChangeStatusOfferEntity>> execute(
      ChangeStatusOfferParams params) {
    return viewOfferRepo.changeStatusOffer(params.offerHeadId);
  }
}

class ChangeStatusOfferParams {
  final int offerHeadId;

  ChangeStatusOfferParams(
    this.offerHeadId,
  );
}
