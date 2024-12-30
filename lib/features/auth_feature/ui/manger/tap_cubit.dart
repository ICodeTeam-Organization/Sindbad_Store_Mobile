import 'package:flutter_bloc/flutter_bloc.dart';

class TabState {
  final int currentIndex;

  TabState(this.currentIndex);
}

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState(0));

  void updateIndex(int index) {
    emit(TabState(index));
  }
}
