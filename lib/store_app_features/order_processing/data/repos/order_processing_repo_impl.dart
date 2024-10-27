import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/data/data_sources/order_processing_remote_data_source.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/domain/entities/order_processing_entity.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/domain/repos/order_processing_repo.dart';

class OrderProcessingRepoImpl extends OrderProcessingRepo {
  final OrderProcessingRemoteDataSource orderProcessingRemoteDataSource;

  OrderProcessingRepoImpl(this.orderProcessingRemoteDataSource);

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
  Future<Either<Failure, List<OrderProcessingEntity>>> fetchOrderProcessing(
      {required String storeId, required int orderId}) {
    return fetchData(() =>
        orderProcessingRemoteDataSource.fetchOrderProcessing(storeId, orderId));
  }
}
