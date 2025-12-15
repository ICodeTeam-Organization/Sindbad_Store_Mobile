import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';

abstract class ViewOfferRemotDataSource {
  Future<List<OfferEntity>> getOffer(
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
}
