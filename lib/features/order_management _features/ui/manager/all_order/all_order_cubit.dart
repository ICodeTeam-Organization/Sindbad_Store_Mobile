import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/all_order_entity.dart';
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
