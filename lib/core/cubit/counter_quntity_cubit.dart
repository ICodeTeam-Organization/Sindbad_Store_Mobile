import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_quntity_state.dart';

class CounterQuntityCubit extends Cubit<CounterQuntityState> {
  int conter = 1;
  CounterQuntityCubit() : super(CounterQuntityInitial());
  static CounterQuntityCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  increceConter() {
    conter++;
    emit(CounterIncrementState());
  }

  decreceConter() {
    if (conter > 1) {
      conter--;
      emit(CounterDecrementState());
    }
  }
}
