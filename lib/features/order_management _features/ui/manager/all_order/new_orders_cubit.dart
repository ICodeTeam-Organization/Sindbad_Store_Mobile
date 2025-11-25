import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/all_order_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/new_orders_cubit_states.dart';

class NewOrdersCubit extends Cubit<NewOrdersState> {
  final NewOrderUsecase allOrderUseCase;

  NewOrdersCubit(this.allOrderUseCase) : super(NewOrdersInitial());

  void fetchOrders(int status) async {
    emit(NewOrdersLoadInProgress());

    // Generate random orders
    final random = Random();
    final orderCount = random.nextInt(11) + 10; // Random 10-20 orders

    final statuses = [
      'Delivered',
      'Pending',
      'Processing',
      'Cancelled',
      'Returned',
      'Shipped'
    ];
    final payStatuses = ['Paid', 'Unpaid', 'Refunded', 'Partial'];

    final List<AllOrderEntity> orders = List.generate(orderCount, (index) {
      final orderId = random.nextInt(10000) + 1;
      final packageId = random.nextInt(5000) + 100;
      final productCount = random.nextInt(25) + 1;
      final day = random.nextInt(28) + 1;
      final month = random.nextInt(12) + 1;

      return AllOrderEntity(
        idOrder: orderId,
        idPackage: packageId,
        orderNum: "ORD-2025-${orderId.toString().padLeft(4, '0')}",
        orderBill: "BILL-${(5500 + index).toString()}",
        productMount: productCount.toString(),
        orderStatuse: statuses[random.nextInt(statuses.length)],
        payStatus: payStatuses[random.nextInt(payStatuses.length)],
        orderDates:
            "2025-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
      );
    });

    await Future.delayed(const Duration(seconds: 1));
    emit(NewOrdersLoadSuccess(orders));
    // List<int> statusList;

    // // If user selected "Call"

    // if (status == PackageStatus.all) {
    //   // Fetch all statuses
    //   statusList = [2, 3, 4];
    // } else {
    //   // Fetch only the selected status
    //   statusList = [status];
    // }

    // final result = await allOrderUseCase.execute(
    //   AllOrderParam(
    //     statuses: statusList,
    //     pageNumber: 1,
    //     pageSize: 100,
    //   ),
    // );

    // result.fold(
    //   (failure) => emit(NewOrdersLoadFailure(failure.toString())),
    //   (orders) => emit(NewOrdersLoadSuccess(_orders)),
    // );
  }
}
