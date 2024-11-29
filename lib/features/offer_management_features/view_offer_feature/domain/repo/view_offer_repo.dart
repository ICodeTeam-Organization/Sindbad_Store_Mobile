import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';

abstract class ViewOfferRepo {
  Future<Either<Failure, List<OfferEntity>>> getOffer(
    int pageSize,
    int pageNumber,
  );
  Future<Either<Failure, List<OfferDetailsEntity>>> getOfferDetails({
    int pageSize = 10,
    int pageNumber = 1,
    required int offerHeadId,
  });
}
