// // bill_cubit.dart
// import 'package:bloc/bloc.dart';
// import 'refresh_page_state.dart';

// class BillCubit extends Cubit<BillState> {
//   BillCubit() : super(BillInitial());

//   void toggleBillStatus() {
//     final currentState = state;
//     if (currentState is BillInitial) {
//       emit(BillUpdated(true)); // تغيير القيمة إلى true
//     } else if (currentState is BillUpdated) {
//       emit(BillUpdated(
//           !currentState.isBillDone)); // تغيير القيمة بناءً على الحالة الحالية
//     }
//   }
// }
import 'package:bloc/bloc.dart';
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
