import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/no_param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class GetAllOfferUseCase extends UseCaseWithNoParam {
  final ViewOfferRepo viewOfferRepo;

  GetAllOfferUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, List<OfferEntity>?>> execute() {
    return viewOfferRepo.getOffer();
  }
}
