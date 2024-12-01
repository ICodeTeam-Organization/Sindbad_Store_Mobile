import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/repo/new_offer_repo.dart';

class NewOfferRepoImpl extends NewOfferRepo {
  final NewOfferRemotDataSource niewOfferRemotDataSource;

  NewOfferRepoImpl(this.niewOfferRemotDataSource);

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

  @override
  Future<Either<Failure, List<OfferProductsEntity>>> getOfferProducts(
      int pageSize, int pageNumber) {
    return fetchData(
        () => niewOfferRemotDataSource.getOfferProducts(pageSize, pageNumber));
  }
}
