import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/read_notificton_use_case.dart';

import '../../../domin/entity/read_notificton.dart';

part 'read_notifiction_state.dart';

class ReadNotifictionCubit extends Cubit<ReadNotifictionState> {
  final ReadNotifictonUseCase readNotifictonUseCase;
  ReadNotifictionCubit(this.readNotifictonUseCase)
      : super(ReadNotifictionInitial());

  Future<void> readNotifiction(int notifictionId) async {
    emit(ReadNotiftionLoading());
    final result = await readNotifictonUseCase
        .execute(ReadNotfictionParm(notifictionId: notifictionId));
    result.fold((l) => emit(ReadNotifictionFailure(errorMessage: l.message)),
        (r) => emit(ReadNotifictionSuccess(notifictionList: r)));
  }
}
