import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';

abstract class OffersRepository {
  // View Offer Operations
  Future<Either<Failure, List<OfferEntity>>> getOffers(
    int pageSize,
    int pageNumber,
  );

  Future<Either<Failure, List<OfferDetailsEntity>>> getOfferDetails(
    int pageSize,
    int pageNumber,
    int offerHeadId,
  );

  Future<Either<Failure, PostResponseEntity>> deleteOffer(
    int offerHeadId,
  );

  Future<Either<Failure, PostResponseEntity>> changeStatusOffer(
    int offerHeadId,
  );

  // New/Edit Offer Operations
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
    int pageSize,
    int pageNumber,
  );

  Future<Either<Failure, bool>> addOffer({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int numberOfOrders,
    required int offerHeadType,
    required List<Map<String, dynamic>> offerHeadOffers,
  });

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
