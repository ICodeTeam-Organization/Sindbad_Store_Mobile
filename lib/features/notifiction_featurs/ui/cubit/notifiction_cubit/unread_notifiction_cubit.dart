import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/entity/get_unread_nutficon.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/get_unread_notiftion.dart';

part 'unread_notifiction_state.dart';

class UnreadNotifictionCubit extends Cubit<UnreadNotifictionState> {
  final GetUnreadNotiftionUseCase getUnreadNotiftionUseCase;
  UnreadNotifictionCubit(this.getUnreadNotiftionUseCase)
      : super(UnreadNotifictionInitial());

  Future<void> getUnreadNotifiction(int type) async {
    emit(UnreadNotifictionLoading());
    var result = await getUnreadNotiftionUseCase
        .execute(UnreadNotiftionParams(type: type));
    result.fold((l) => emit(UnreadNotifictionFailure(l.message)),
        (r) => emit(UnreadNotifictionSuccess(r)));
  }
}
