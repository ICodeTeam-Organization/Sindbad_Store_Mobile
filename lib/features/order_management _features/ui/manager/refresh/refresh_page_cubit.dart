import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'refresh_page_state.dart';

class RefreshPageCubit extends Cubit<RefreshPageState> {
  bool isbillDone = false;
  RefreshPageCubit() : super(RefreshPageInitial());
  refreshpage() {
    isbillDone = true;
  }
}
