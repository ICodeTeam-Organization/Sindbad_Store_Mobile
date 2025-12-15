import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';

abstract class OfferRemotDataSource {
  // View Offer Operations
  Future<List<OfferEntity>> getOffers(
    int pageSize,
    int pageNumber,
  );

  Future<List<OfferDetailsEntity>> getOfferDetails(
    int pageSize,
    int pageNumber,
    int offerHeadId,
  );

  Future<PostResponseEntity> deleteOffer(
    int offerHeadId,
  );

  Future<PostResponseEntity> changeStatusOffer(
    int offerHeadId,
  );

  // New/Edit Offer Operations
  Future<List<OfferProductsEntity>> getOfferProducts(
    int pageSize,
    int pageNumber,
  );

  Future<bool> addOffer({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int numberOfOrders,
    required int offerHeadType,
    required List<Map<String, dynamic>> offerHeadOffers,
  });

  Future<UpdateOfferEntity> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  );

  Future<OfferDataEntity> getOfferData(
    int offerHeadId,
  );
}
