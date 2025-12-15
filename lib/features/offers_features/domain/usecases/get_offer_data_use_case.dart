import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';

class GetOfferDataUseCase
    extends UseCaseWithParam<OfferDataEntity, OfferDataParams> {
  final OffersRepositoryImpl offersRepository;

  GetOfferDataUseCase(this.offersRepository);

  @override
  Future<Either<Failure, OfferDataEntity>> execute(OfferDataParams params) {
    return offersRepository.getOfferData(
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
