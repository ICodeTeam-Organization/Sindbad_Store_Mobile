import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/nottifction_entity.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/get_notifiction_use_case.dart';

part 'notifiction_state.dart';

class NotifictionCubit extends Cubit<NotifictionState> {
  final GetNotifictionUseCase getNotifictionUseCase;
  NotifictionCubit(this.getNotifictionUseCase) : super(NotifictionInitial());

  Future<void> getNotifiction(
      {required int pageNumber,
      required int pageSize,
      required int type}) async {
    if (pageNumber > 1) {
      emit(NotifictionPagtionLoading());
    } else {
      emit(NotifictionLoading());
    }
    var parm = NotifctionParm(
        pageNumber: pageNumber, pageSize: pageSize, status: type);
    var result = await getNotifictionUseCase.execute(parm);
    result.fold((failuer) {
      if (pageNumber != 1) {
        emit(NotiftionPagtionFailure(errorMessage: failuer.message));
      } else {
        emit(NotifictionFailure(errorMessage: failuer.message));
      }
    },
        (notfications) =>
            emit(NotifictionSuccess(notifictionList: notfications)));
  }
}
