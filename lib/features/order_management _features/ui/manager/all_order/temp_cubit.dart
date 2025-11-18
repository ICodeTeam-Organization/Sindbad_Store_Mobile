import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/temp_cubit_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final AllOrderUsecase allOrderUseCase;

  OrdersCubit(this.allOrderUseCase) : super(OrdersInitial());

  void fetchOrders(int status) async {
    emit(OrdersLoadInProgress());

    await Future.delayed(const Duration(seconds: 1));

    List<int> statusList;

    // If user selected "Call"
    const int callStatus = 0; // or whatever ID you use for "Call"

    if (status == PackageStatus.all) {
      // Fetch all statuses
      statusList = [1, 2, 3, 4, 5, 6, 7];
    } else {
      // Fetch only the selected status
      statusList = [status];
    }

    final result = await allOrderUseCase.execute(
      AllOrderParam(
        statuses: statusList,
        isUrgent: true,
        pageNumber: 1,
        pageSize: 100,
      ),
    );

    result.fold(
      (failure) => emit(OrdersLoadFailure(failure.toString())),
      (orders) => emit(OrdersLoadSuccess(orders)),
    );
  }
}
