import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';

sealed class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoadInProgress extends OrdersState {}

class OrdersLoadSuccess extends OrdersState {
  final List<AllOrderEntity> orders;
  OrdersLoadSuccess(this.orders);
}

class OrdersLoadFailure extends OrdersState {
  final String message;
  OrdersLoadFailure(this.message);
}
