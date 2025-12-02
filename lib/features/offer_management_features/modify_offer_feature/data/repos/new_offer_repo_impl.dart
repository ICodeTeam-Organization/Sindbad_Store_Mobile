import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_data_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/update_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/repo/new_offer_repo.dart';

class NewOfferRepoImpl extends NewOfferRepo {
  final NewOfferRemotDataSourceImpl newOfferRemotDataSource;

  NewOfferRepoImpl(this.newOfferRemotDataSource);

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

  // basic fetch Entity function
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
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
      int pageSize, int pageNumber) {
    return fetchData(
        () => newOfferRemotDataSource.getOfferProducts(pageSize, pageNumber));
  }

  @override
  Future<Either<Failure, OfferDataEntity>> getOfferData(int offerHeadId) {
    return fetchOneData(
        () => newOfferRemotDataSource.getOfferData(offerHeadId));
  }

  @override
  Future<Either<Failure, AddOfferEntity>> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    List<Map<String, dynamic>>? listProduct,
  ) async {
    return postOneData(() => newOfferRemotDataSource.addOffer(
          offerTitle,
          startOffer,
          endOffer,
          countProducts,
          typeName,
          listProduct,
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
  ) async {
    return postOneData(() => newOfferRemotDataSource.updateOffer(
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
