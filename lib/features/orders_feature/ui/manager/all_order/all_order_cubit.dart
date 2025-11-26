import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';
import '../../../domain/usecases/all_order_usecase.dart';
import 'all_order_state.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  AllOrderCubit(this.allOrderUseCase)
      : super(
          AllOrderInitial(),
        );
  final NewOrderUsecase allOrderUseCase;
  Future<void> fetchAllOrder({
    required List<int> statuses,
    required bool isUrgent,
    required int pageNumber,
    required int pageSize,
    // required String storeId,
    // required String srearchKeyword,
  }) async {
    if (pageNumber == 1) {
      emit(
        AllOrderLoading(),
      );
    } else {
      emit(
        AllOrderPaginationLoadging(),
      );
    }

    var result = await allOrderUseCase.execute(AllOrderParam(
      statuses: statuses,
      isUrgent: isUrgent,
      pageNumber: pageNumber,
      pageSize: pageSize,
      // storeId: storeId,
      // srearchKeyword: srearchKeyword
    ));

    // Generate random orders
    final random = Random();
    final orderCount = random.nextInt(11) + 10; // Random 10-20 orders

    // Order status codes: 2, 3, 4, 5, 6
    // '2': بدون فاتورة (No Invoice - Grey Color(0xffE8E8E8))
    // '3': لم تسدد (Not Paid - Pink Color(0xCCFFF2F5))
    // '4': للشحن (For Shipping - Cyan Color(0xffCEECF0))
    // '5' & '6': سابقة (Previous - Blue Color(0xffCDE8F6))
    final orderStatuses = ['2', '3', '4', '5', '6'];
    final payStatuses = ['Paid', 'Unpaid', 'Refunded', 'Partial'];

    final List<AllOrderEntity> _orders = List.generate(orderCount, (index) {
      final orderId = random.nextInt(10000) + 1;
      final packageId = random.nextInt(5000) + 100;
      final productCount = random.nextInt(25) + 1;
      final day = random.nextInt(28) + 1;
      final month = random.nextInt(12) + 1;
      final orderStatus = orderStatuses[random.nextInt(orderStatuses.length)];

      return AllOrderEntity(
        idOrder: orderId,
        idPackage: packageId,
        orderNum: "ORD-2025-${orderId.toString().padLeft(4, '0')}",
        orderBill: "BILL-${(5500 + index).toString()}",
        productMount: productCount.toString(),
        orderStatuse: orderStatus, // Using status code (2, 3, 4, 5, 6)
        payStatus: payStatuses[random.nextInt(payStatuses.length)],
        orderDates:
            "2025-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
      );
    });

    result.fold((failuer) {
      if (pageNumber == 1) {
        emit(
          AllOrderFailuer(errMessage: failuer.toString()),
        );
      } else {
        emit(
          AllOrderPaginationFaliure(errMessage: failuer.toString()),
        );
      }
    }, (orders) {
      emit(AllOrderSuccess(orders: _orders));
    });
  }
}
