import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
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

class UpdateOfferParams {
  final String offerTitle;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final int typeName;
  final List<OfferHeadOffer>? listProduct;
  final int offerHeadId;

  UpdateOfferParams(
    this.offerTitle,
    this.startOffer,
    this.endOffer,
    this.countProducts,
    this.typeName,
    this.listProduct,
    this.offerHeadId,
  );
}
