import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/models/add_offer_model/add_offer_dto.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/repo/new_offer_repo.dart';

class AddOfferUseCase extends UseCaseWithParam<AddOfferEntity, AddOfferParams> {
  final NewOfferRepo newOfferRepo;

  AddOfferUseCase(this.newOfferRepo);

  @override
  Future<Either<Failure, AddOfferEntity>> execute(AddOfferParams params) {
    return newOfferRepo.addOffer(
      params.offerTitle,
      params.startOffer,
      params.endOffer,
      params.countProducts,
      params.typeName,
      params.listProduct,
    );
  }
}

class AddOfferParams {
  final String offerTitle;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final int typeName;
  // final List<AddOfferDto>? listProduct;
  final List<Map<String, dynamic>>? listProduct;

  AddOfferParams(
    this.offerTitle,
    this.startOffer,
    this.endOffer,
    this.countProducts,
    this.typeName,
    this.listProduct,
  );
}
