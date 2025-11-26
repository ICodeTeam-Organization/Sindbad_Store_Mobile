abstract class ButtonDisableEvent {}

class EnableButtonForOrder extends ButtonDisableEvent {
  final String orderId;

  EnableButtonForOrder({required this.orderId});
}
