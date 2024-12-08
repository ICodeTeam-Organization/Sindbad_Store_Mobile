import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'refresh_page_state.dart';

class RefreshPageCubit extends Cubit<RefreshPageState> {
  RefreshPageCubit() : super(RefreshPageInitial());

  static RefreshPageCubit get(context) => BlocProvider.of(context);

  bool isbillDone = false;
  void refreshpage() {
    isbillDone = !isbillDone;
    emit(ChangeVisibiltyButtonsState());
  }
}
