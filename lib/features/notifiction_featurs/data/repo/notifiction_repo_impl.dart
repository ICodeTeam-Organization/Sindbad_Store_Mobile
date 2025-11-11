import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/remote_data/notifiction_remote_data_source.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/read_notificton.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/repo/notifiction_repo.dart';

class NotifictionRepoImpl extends NotifictionRepo {
  final NotifictionRemoteDataSourceImpl notifictionRemoteDataSource;
  NotifictionRepoImpl(this.notifictionRemoteDataSource);
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

  Future<Either<Failure, T>> addData<T>(
      Future<T> Function() addFunction) async {
    try {
      var dataAdded = await addFunction();
      return right(dataAdded);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<NotifctionEntity>>> getNotifiction(
      {required int pageNumber, required int pageSize, required int type}) {
    return fetchData(() => notifictionRemoteDataSource.getNotifiction(
        pageNumber: pageNumber, pageSize: pageSize, type: type));
  }

  @override
  Future<Either<Failure, List<GetUnreadNutficonEntity>>> getUnreadNotifiction(
      int type) {
    return addData(
        () => notifictionRemoteDataSource.getUnreadNotifiction(type));
  }

  @override
  Future<Either<Failure, ReadNotifictonEntity>> readNotifction(int id) {
    return addData(() => notifictionRemoteDataSource.readNotifction(id));
  }
}
