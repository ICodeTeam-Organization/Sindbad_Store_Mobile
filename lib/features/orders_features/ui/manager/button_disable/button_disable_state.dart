part of 'button_disable_cubit.dart';

class ButtonDisableState {
  final Map<String, bool> orderButtonStates; // Track button states by order ID

  ButtonDisableState({required this.orderButtonStates});

  bool isButtonEnabled(String orderId) {
    return orderButtonStates[orderId] ?? false; // Default to true if not set
  }
}
