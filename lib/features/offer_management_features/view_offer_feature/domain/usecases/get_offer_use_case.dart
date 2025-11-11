import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class GetOfferUseCase extends UseCaseWithParam<List<OfferEntity>, OfferParams> {
  final ViewOfferRepo viewOfferRepo;

  GetOfferUseCase(this.viewOfferRepo);

  @override
  Future<Either<Failure, List<OfferEntity>>> execute(OfferParams params) {
    return viewOfferRepo.getOffer(
      params.pageSize,
      params.pageNumber,
    );
  }
}

class OfferParams {
  final int pageSize;
  final int pageNumber;
  OfferParams(
    this.pageSize,
    this.pageNumber,
  );
}
