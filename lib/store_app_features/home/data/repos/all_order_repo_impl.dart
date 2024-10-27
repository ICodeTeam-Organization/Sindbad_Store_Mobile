import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/store_app_features/home/data/data_sources/all_order_remote_data_source.dart';
import 'package:sindbad_management_app/store_app_features/home/domain/entities/all_order_entity.dart';
import 'package:sindbad_management_app/store_app_features/home/domain/repos/all_order_repo.dart';

class AllOrderRepoImpl extends AllOrderRepo {
  final AllOrderRemotDataSource allOrderRemotDataSource;

  AllOrderRepoImpl(this.allOrderRemotDataSource);

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
  Future<Either<Failure, List<AllOrderEntity>>> fetchAllOrder(
      {required int pageNumber,
      required int pageSize,
      required String storeId,
      required int srearchKeyword}) {
    return fetchData(() => allOrderRemotDataSource.fetchAllOrder(
        storeId, pageSize, pageNumber, srearchKeyword));
  }
}
