import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/all_order_entity.dart';
import '../../domain/repos/all_order_repo.dart';
import '../data_sources/all_order_remot_data_source.dart';

class AllOrderRepoImpl extends AllOrderRepo {
  final AllOrderRemotDataSource allOrderRemotDataSource;

  AllOrderRepoImpl(
    this.allOrderRemotDataSource,
  );

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
      {required bool isUrgen,
      int pageNumber = 1,
      required int pageSize,
      required int orderDetailStatus,
      required String srearchKeyword}) {
    return fetchData(() => allOrderRemotDataSource.fetchAllOrder(
        isUrgen, orderDetailStatus, pageSize, pageNumber, srearchKeyword));
  }
}
