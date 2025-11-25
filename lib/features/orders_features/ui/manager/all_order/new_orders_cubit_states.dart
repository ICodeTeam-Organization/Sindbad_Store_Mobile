import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/orders_features/domain/entities/all_order_entity.dart';

sealed class NewOrdersState {}

class NewOrdersInitial extends NewOrdersState {}

class NewOrdersLoadInProgress extends NewOrdersState {}

class NewOrdersLoadSuccess extends NewOrdersState {
  final List<AllOrderEntity> orders;
  NewOrdersLoadSuccess(this.orders);
}

class NewOrdersLoadFailure extends NewOrdersState {
  final String message;
  NewOrdersLoadFailure(this.message);
}
