import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/temp_cubit_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final AllOrderUsecase allOrderUseCase;

  OrdersCubit(this.allOrderUseCase) : super(OrdersInitial());

  void fetchOrders(String status) async {
    emit(OrdersLoadInProgress());

    // Simulate API callf
    await Future.delayed(Duration(seconds: 1));
    // Convert status to int and fetch orders (fallback to 0 if parsing fails)
    // final orders = _getOrdersByStatus(int.tryParse(status) ?? 0);

    var result = await allOrderUseCase.execute(AllOrderParam(
      statuses: [2, 3, 4],
      isUrgent: true,
      pageNumber: 10,
      pageSize: 100,
      // storeId: storeId,
      // srearchKeyword: srearchKeyword
    ));

    result.fold((failuer) {
      emit(
        OrdersLoadFailure(failuer.toString()),
      );
    }, (orders) {
      emit(OrdersLoadSuccess(orders));
    });
  }
}
