import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/models/offer_details_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/models/offer_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/models/post_response_model.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/post_response_entity.dart';

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
