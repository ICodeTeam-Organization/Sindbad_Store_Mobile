import 'package:flutter_bloc/flutter_bloc.dart';

import 'refresh_page_state.dart';

class RefreshPageCubit extends Cubit<RefreshPageState> {
  RefreshPageCubit() : super(RefreshInitial());

  void toggleBillStatus(int orderId) {
    final currentState = state;

    if (currentState is RefreshInitial || currentState is RefreshUpdated) {
      // Retrieve current orders status map
      final currentOrdersStatus = currentState is RefreshInitial
          ? currentState.ordersStatus
          : (currentState as RefreshUpdated).ordersStatus;

      // Create a new map with updated status for the specific order
      final updatedOrdersStatus = Map<int, bool>.from(currentOrdersStatus);
      updatedOrdersStatus[orderId] = !(updatedOrdersStatus[orderId] ?? false);

      // Emit the updated state
      emit(RefreshUpdated(updatedOrdersStatus));
    }
  }
}
