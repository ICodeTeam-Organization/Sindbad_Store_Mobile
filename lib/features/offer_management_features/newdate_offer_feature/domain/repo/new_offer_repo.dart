import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/data/models/add_offer_model/add_offer_dto.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/domain/entities/offer_products_entity.dart';

abstract class NewOfferRepo {
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
    int pageSize,
    int pageNumber,
  );
  Future<Either<Failure, AddOfferEntity>> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<Map<String, dynamic>>? listProduct,
  );
}
