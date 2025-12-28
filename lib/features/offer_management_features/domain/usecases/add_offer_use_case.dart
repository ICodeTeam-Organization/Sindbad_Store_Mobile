import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/add_offer_entity.dart';

class AddOfferUseCase extends UseCaseWithParam<AddOfferEntity, AddOfferParams> {
  final NewOfferRepositoryImpl newOfferRepo;

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
