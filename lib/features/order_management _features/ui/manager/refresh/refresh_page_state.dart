// // bill_state.dart
// abstract class BillState {}

// class BillInitial extends BillState {
//   final bool isBillDone;

//   BillInitial({this.isBillDone = false});
// }

// class BillUpdated extends BillState {
//   final bool isBillDone;

//   BillUpdated(this.isBillDone);
// }
abstract class RefreshPageState {}

class RefreshInitial extends RefreshPageState {
  final Map<int, bool> ordersStatus;

  RefreshInitial({this.ordersStatus = const {}}); // Default empty map
}

class RefreshUpdated extends RefreshPageState {
  final Map<int, bool> ordersStatus;

  RefreshUpdated(this.ordersStatus);
}
