import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/data/data_source/remote/view_offer_remot_data_source_impl.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/update_offer_entity.dart';
import 'package:sindbad_management_app/features/offers_features/domain/repo/offers_repository.dart';

class OffersRepositoryImpl extends OffersRepository {
  final ViewOfferRemotDataSourceImpl offersRemotDataSource;

  OffersRepositoryImpl(this.offersRemotDataSource);

  // basic fetch list Entity function
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

  // Generic PostData function
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

  @override
  Future<Either<Failure, List<OfferEntity>>> getOffers(
      int pageSize, int pageNumber) {
    return fetchData(
        () => offersRemotDataSource.getOffer(pageSize, pageNumber));
  }

  @override
  Future<Either<Failure, List<OfferDetailsEntity>>> getOfferDetails(
      int pageSize, int pageNumber, int offerHeadId) {
    return fetchData(() => offersRemotDataSource.getOfferDetails(
        pageSize, pageNumber, offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> deleteOffer(
    int offerHeadId,
  ) async {
    return postOneData(() => offersRemotDataSource.deleteOffer(offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> changeStatusOffer(
    int offerHeadId,
  ) async {
    return postOneData(
        () => offersRemotDataSource.changeStatusOffer(offerHeadId));
  }

  @override
  Future<Either<Failure, bool>> addOffer(
      {required String name,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      required bool isActive,
      required int numberOfOrders,
      required int offerHeadType,
      required List<Map<String, dynamic>> offerHeadOffers}) {
    // TODO: implement addOffer
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, OfferDataEntity>> getOfferData(int offerHeadId) {
    // TODO: implement getOfferData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
      int pageSize, int pageNumber) {
    // TODO: implement getOfferProducts
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UpdateOfferEntity>> updateOffer(
      String offerTitle,
      DateTime startOffer,
      DateTime endOffer,
      int countProducts,
      int typeName,
      List<OfferHeadOffer>? listProduct,
      int offerHeadId) {
    // TODO: implement updateOffer
    throw UnimplementedError();
  }
}
