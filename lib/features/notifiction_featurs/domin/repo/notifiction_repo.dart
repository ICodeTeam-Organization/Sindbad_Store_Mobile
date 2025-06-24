import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/read_notificton.dart';

abstract class NotifictionRepo {
  Future<Either<Failure, List<NotifctionEntity>>> getNotifiction(
      {required int pageNumber, required int pageSize, required int type});
  Future<Either<Failure, GetUnreadNutficonEntity>> getUnreadNotifiction(
      int type);
  Future<Either<Failure, ReadNotifictonEntity>> readNotifction(int id);
}
