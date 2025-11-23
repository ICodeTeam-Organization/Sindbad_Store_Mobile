import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/all_order_entity.dart';

sealed class UrgentOrderState {}

class UrgentOrdersInitial extends UrgentOrderState {}

class UrgentOrdersLoadInProgress extends UrgentOrderState {}

class UrgentOrdersLoadSuccess extends UrgentOrderState {
  final List<AllOrderEntity> orders;
  UrgentOrdersLoadSuccess(this.orders);
}

class UrgentOrdersLoadFailure extends UrgentOrderState {
  final String message;
  UrgentOrdersLoadFailure(this.message);
}
