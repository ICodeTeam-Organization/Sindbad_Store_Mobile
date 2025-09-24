import 'package:flutter/material.dart';

import '../../../domain/entities/all_order_entity.dart';

@immutable
sealed class AllOrderState {}

final class AllOrderInitial extends AllOrderState {}

final class AllOrderLoading extends AllOrderState {}

final class AllOrderFailuer extends AllOrderState {
  final String errMessage;

  AllOrderFailuer({required this.errMessage});
}

final class AllOrderSuccess extends AllOrderState {
  final List<AllOrderEntity> orders;

  AllOrderSuccess({required this.orders});
}

/// for pagination

final class AllOrderPaginationLoadging extends AllOrderState {}

final class AllOrderPaginationFaliure extends AllOrderState {
  final String errMessage;

  AllOrderPaginationFaliure({required this.errMessage});
}
