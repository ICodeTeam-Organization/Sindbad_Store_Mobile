import 'package:flutter_bloc/flutter_bloc.dart';
part 'button_disable_state.dart';

class ButtonDisableCubit extends Cubit<ButtonDisableState> {
  ButtonDisableCubit() : super(ButtonDisableState(orderButtonStates: {}));
  void enableButtonForOrder(String orderId) {
    final updatedStates = Map<String, bool>.from(state.orderButtonStates);
    updatedStates[orderId] =
        true; // Set the specific button to enabled (false means enabled)
    emit(ButtonDisableState(orderButtonStates: updatedStates));
  }
}
