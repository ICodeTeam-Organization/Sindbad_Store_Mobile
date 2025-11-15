import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/temp_cubit_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  void fetchOrders(int status) async {
    emit(OrdersLoading());
    try {
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      List<Order> orders = _getOrdersByStatus(status);
      // emit(OrdersLoaded(orders.cast<Order>()));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  List<Order> _getOrdersByStatus(int status) {
    // Example dummy data
    if (status == 1) return [Order("Order 1"), Order("Order 2")];
    if (status == 2) return [Order("Order 3")];
    return [];
  }
}

class Order {
  final String name;
  Order(this.name);
}
