import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/repo/notifiction_repo.dart';

class GetNotifictionUseCase
    extends UseCaseWithParam<List<NotifctionEntity>, NotifctionParm> {
  final NotifictionRepo notifictionRepo;
  GetNotifictionUseCase(this.notifictionRepo);
  @override
  Future<Either<Failure, List<NotifctionEntity>>> execute(params) {
    return notifictionRepo.getNotifiction(
        pageNumber: params.pageNumber,
        pageSize: params.pageSize,
        type: params.status);
  }
}

class NotifctionParm {
  final int pageNumber;
  final int pageSize;
  final int status;
  NotifctionParm(
      {required this.pageNumber, required this.pageSize, required this.status});
}
