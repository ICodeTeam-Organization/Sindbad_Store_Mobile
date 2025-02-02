abstract class RefreshPageState {}

class RefreshInitial extends RefreshPageState {
  final Map<int, bool> ordersStatus;

  RefreshInitial({this.ordersStatus = const {}}); // Default empty map
}

class RefreshUpdated extends RefreshPageState {
  final Map<int, bool> ordersStatus;

  RefreshUpdated(this.ordersStatus);
}
