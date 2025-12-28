import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/update_offer_entity.dart';

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
  Future<Either<Failure, UpdateOfferEntity>> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  );
  Future<Either<Failure, OfferDataEntity>> getOfferData(
    int offerHeadId,
  );
}
