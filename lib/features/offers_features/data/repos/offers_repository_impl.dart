import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offers_features/data/data_source/remote/offer_remot_data_source_impl.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/repo/offers_repository.dart';

class OffersRepositoryImpl extends OffersRepository {
  final OfferRemotDataSourceImpl offerRemotDataSource;

  OffersRepositoryImpl(this.offerRemotDataSource);

  // Generic fetch list function
  Future<Either<Failure, List<T>>> fetchData<T>(
      Future<List<T>> Function() fetchFunction) async {
    try {
      var data = await fetchFunction();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // Generic fetch single entity function
  Future<Either<Failure, T>> fetchOneData<T>(
      Future<T> Function() fetchFunction) async {
    try {
      var data = await fetchFunction();
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // Generic post data function
  Future<Either<Failure, T>> postOneData<T>(
      Future<T> Function() postDataFunction) async {
    try {
      var dataPosted = await postDataFunction();
      return right(dataPosted);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // ============================================================
  // View Offer Operations
  // ============================================================

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers(
      int pageSize, int pageNumber) async {
    try {
      var data = await offerRemotDataSource.getOffers(pageSize, pageNumber);
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<OfferDetailsEntity>>> getOfferDetails(
      int pageSize, int pageNumber, int offerHeadId) {
    return fetchData(() => offerRemotDataSource.getOfferDetails(
        pageSize, pageNumber, offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> deleteOffer(int offerHeadId) {
    return postOneData(() => offerRemotDataSource.deleteOffer(offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> changeStatusOffer(
      int offerHeadId) {
    return postOneData(
        () => offerRemotDataSource.changeStatusOffer(offerHeadId));
  }

  // ============================================================
  // New/Edit Offer Operations
  // ============================================================

  @override
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
      int pageSize, int pageNumber) {
    return fetchData(
        () => offerRemotDataSource.getOfferProducts(pageSize, pageNumber));
  }

  @override
  Future<Either<Failure, OfferDataEntity>> getOfferData(int offerHeadId) {
    return fetchOneData(() => offerRemotDataSource.getOfferData(offerHeadId));
  }

  @override
  Future<Either<Failure, bool>> addOffer({
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    required bool isActive,
    required int numberOfOrders,
    required int offerHeadType,
    required List<Map<String, dynamic>> offerHeadOffers,
  }) {
    return postOneData(() => offerRemotDataSource.addOffer(
          name: name,
          description: description,
          startDate: startDate,
          endDate: endDate,
          isActive: isActive,
          numberOfOrders: numberOfOrders,
          offerHeadType: offerHeadType,
          offerHeadOffers: offerHeadOffers,
        ));
  }

  @override
  Future<Either<Failure, UpdateOfferEntity>> updateOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<OfferHeadOffer>? listProduct,
    int offerHeadId,
  ) {
    return postOneData(() => offerRemotDataSource.updateOffer(
          offerTitle,
          startOffer,
          endOffer,
          countProducts,
          typeName,
          listProduct,
          offerHeadId,
        ));
  }
}
