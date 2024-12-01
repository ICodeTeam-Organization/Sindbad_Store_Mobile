import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/offer_products_entity.dart';

abstract class NewOfferRepo {
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
    int pageSize,
    int pageNumber,
  );
}
