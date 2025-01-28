import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class DeleteOfferUseCase
    extends UseCaseWithParam<PostResponseEntity, DeleteOfferParams> {
  final ViewOfferRepo viewOfferRepo;

  DeleteOfferUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, PostResponseEntity>> execute(
      DeleteOfferParams params) {
    return viewOfferRepo.deleteOffer(params.offerHeadId);
  }
}

class DeleteOfferParams {
  final int offerHeadId;

  DeleteOfferParams(
    this.offerHeadId,
  );
}
