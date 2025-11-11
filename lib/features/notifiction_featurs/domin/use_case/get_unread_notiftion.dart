import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/repo/notifiction_repo.dart';

class GetUnreadNotiftionUseCase extends UseCaseWithParam<
    List<GetUnreadNutficonEntity>, UnreadNotiftionParams> {
  final NotifictionRepo notifictionRepo;
  GetUnreadNotiftionUseCase({required this.notifictionRepo});
  @override
  Future<Either<Failure, List<GetUnreadNutficonEntity>>> execute(params) {
    // TODO: implement execute
    return notifictionRepo.getUnreadNotifiction(params.type);
  }
}

class UnreadNotiftionParams {
  final int type;

  UnreadNotiftionParams({required this.type});
}
