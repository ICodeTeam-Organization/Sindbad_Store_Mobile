import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/read_notificton.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/repo/notifiction_repo.dart';

class ReadNotifictonUseCase
    extends UseCaseWithParam<ReadNotifictonEntity, ReadNotfictionParm> {
  final NotifictionRepo notifictionRepo;
  ReadNotifictonUseCase({required this.notifictionRepo});
  @override
  Future<Either<Failure, ReadNotifictonEntity>> execute(
      ReadNotfictionParm params) {
    // TODO: implement execute
    return notifictionRepo.readNotifction(params.notifictionId);
  }
}

class ReadNotfictionParm {
  final int notifictionId;
  ReadNotfictionParm({required this.notifictionId});
}
