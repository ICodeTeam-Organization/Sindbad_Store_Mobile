import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/data/models/add_offer_model/add_offer_dto.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/domain/entities/add_offer_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/newdate_offer_feature/domain/repo/new_offer_repo.dart';

class NewOfferRepoImpl extends NewOfferRepo {
  final NewOfferRemotDataSource newOfferRemotDataSource;

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
  Future<Either<Failure, AddOfferEntity>> addOffer(
    String offerTitle,
    DateTime startOffer,
    DateTime endOffer,
    int countProducts,
    int typeName,
    // List<AddOfferDto>? listProduct,
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
}
