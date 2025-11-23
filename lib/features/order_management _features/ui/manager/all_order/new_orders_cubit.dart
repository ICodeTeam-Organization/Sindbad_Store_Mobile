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
    final List<AllOrderEntity> _orders = [
      AllOrderEntity(
        idOrder: 1,
        idPackage: 101,
        orderNum: "ORD-2024-001",
        orderBill: "BILL-5501",
        productMount: "5",
        orderStatuse: "Delivered",
        payStatus: "Paid",
        orderDates: "2025-01-12",
      ),
      AllOrderEntity(
        idOrder: 2,
        idPackage: 102,
        orderNum: "ORD-2024-002",
        orderBill: "BILL-5502",
        productMount: "2",
        orderStatuse: "Pending",
        payStatus: "Unpaid",
        orderDates: "2025-01-15",
      ),
      AllOrderEntity(
        idOrder: 3,
        idPackage: 103,
        orderNum: "ORD-2024-003",
        orderBill: "BILL-5503",
        productMount: "12",
        orderStatuse: "Processing",
        payStatus: "Paid",
        orderDates: "2025-01-18",
      ),
      AllOrderEntity(
        idOrder: 4,
        idPackage: 104,
        orderNum: "ORD-2024-004",
        orderBill: "BILL-5504",
        productMount: "8",
        orderStatuse: "Cancelled",
        payStatus: "Refunded",
        orderDates: "2025-01-05",
      ),
      AllOrderEntity(
        idOrder: 5,
        idPackage: 105,
        orderNum: "ORD-2024-005",
        orderBill: "BILL-5505",
        productMount: "3",
        orderStatuse: "Delivered",
        payStatus: "Paid",
        orderDates: "2025-01-20",
      ),
      AllOrderEntity(
        idOrder: 6,
        idPackage: 106,
        orderNum: "ORD-2024-006",
        orderBill: "BILL-5506",
        productMount: "15",
        orderStatuse: "Returned",
        payStatus: "Refunded",
        orderDates: "2025-01-07",
      ),
      AllOrderEntity(
        idOrder: 7,
        idPackage: 107,
        orderNum: "ORD-2024-007",
        orderBill: "BILL-5507",
        productMount: "1",
        orderStatuse: "Processing",
        payStatus: "Unpaid",
        orderDates: "2025-01-09",
      ),
      AllOrderEntity(
        idOrder: 8,
        idPackage: 108,
        orderNum: "ORD-2024-008",
        orderBill: "BILL-5508",
        productMount: "9",
        orderStatuse: "Delivered",
        payStatus: "Paid",
        orderDates: "2025-01-22",
      ),
      AllOrderEntity(
        idOrder: 9,
        idPackage: 109,
        orderNum: "ORD-2024-009",
        orderBill: "BILL-5509",
        productMount: "7",
        orderStatuse: "Pending",
        payStatus: "Unpaid",
        orderDates: "2025-01-11",
      ),
      AllOrderEntity(
        idOrder: 10,
        idPackage: 110,
        orderNum: "ORD-2024-010",
        orderBill: "BILL-5510",
        productMount: "20",
        orderStatuse: "Processing",
        payStatus: "Paid",
        orderDates: "2025-01-25",
      ),
    ];

    await Future.delayed(const Duration(seconds: 1));

    List<int> statusList;

    // If user selected "Call"

    if (status == PackageStatus.all) {
      // Fetch all statuses
      statusList = [2, 3, 4];
    } else {
      // Fetch only the selected status
      statusList = [status];
    }

    final result = await allOrderUseCase.execute(
      AllOrderParam(
        statuses: statusList,
        pageNumber: 1,
        pageSize: 100,
      ),
    );

    result.fold(
      (failure) => emit(NewOrdersLoadFailure(failure.toString())),
      (orders) => emit(NewOrdersLoadSuccess(_orders)),
    );
  }
}
