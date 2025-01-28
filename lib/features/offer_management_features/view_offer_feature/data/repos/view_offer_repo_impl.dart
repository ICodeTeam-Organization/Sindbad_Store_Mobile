import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/data_source/remote/view_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/post_response_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/repo/view_offer_repo.dart';

class ViewOfferRepoImpl extends ViewOfferRepo {
  final ViewOfferRemotDataSource viewOfferRemotDataSource;

  ViewOfferRepoImpl(this.viewOfferRemotDataSource);

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
  Future<Either<Failure, List<OfferEntity>>> getOffer(
      int pageSize, int pageNumber) {
    return fetchData(
        () => viewOfferRemotDataSource.getOffer(pageSize, pageNumber));
  }

  @override
  Future<Either<Failure, List<OfferDetailsEntity>>> getOfferDetails(
      int pageSize, int pageNumber, int offerHeadId) {
    return fetchData(() => viewOfferRemotDataSource.getOfferDetails(
        pageSize, pageNumber, offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> deleteOffer(
    int offerHeadId,
  ) async {
    return postOneData(() => viewOfferRemotDataSource.deleteOffer(offerHeadId));
  }

  @override
  Future<Either<Failure, PostResponseEntity>> changeStatusOffer(
    int offerHeadId,
  ) async {
    return postOneData(
        () => viewOfferRemotDataSource.changeStatusOffer(offerHeadId));
  }
}
