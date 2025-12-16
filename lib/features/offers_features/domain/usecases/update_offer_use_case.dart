import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/get_offer_updates.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';

class UpdateOfferUseCase
    extends UseCaseWithParam<UpdateOfferEntity, UpdateOfferParams> {
  final OffersRepositoryImpl offersRepository;

  UpdateOfferUseCase(this.offersRepository);

  @override
  Future<Either<Failure, UpdateOfferEntity>> execute(UpdateOfferParams params) {
    return offersRepository.updateOffer(
      params.offerTitle,
      params.startOffer,
      params.endOffer,
      params.countProducts,
      params.typeName,
      params.listProduct,
      params.offerHeadId,
    );
  }
}
