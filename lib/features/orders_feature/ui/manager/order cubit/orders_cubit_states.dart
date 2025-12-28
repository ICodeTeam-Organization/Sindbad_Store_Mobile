import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';

sealed class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoadInProgress extends OrdersState {}

class OrdersLoadMoreInProgress extends OrdersState {
  final List<OrderEntity> orders;
  final int currentPage;
  OrdersLoadMoreInProgress(this.orders, this.currentPage);
}

class OrdersLoadSuccess extends OrdersState {
  final List<OrderEntity> orders;
  final int currentPage;
  final bool hasMore;
  OrdersLoadSuccess(this.orders, {this.currentPage = 1, this.hasMore = true});
}

class OrdersLoadFailure extends OrdersState {
  final String message;
  OrdersLoadFailure(this.message);
}
