import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/urgent_order_cubit_states.dart';

class UrgentOrderCubit extends Cubit<UrgentOrderState> {
  final NewOrderUsecase allOrderUseCase;

  UrgentOrderCubit(this.allOrderUseCase) : super(UrgentOrdersInitial());

  void fetchOrders(int status) async {
    emit(UrgentOrdersLoadInProgress());

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
        isUrgent: true,
        pageNumber: 1,
        pageSize: 100,
      ),
    );

    result.fold(
      (failure) => emit(UrgentOrdersLoadFailure(failure.toString())),
      (orders) => emit(UrgentOrdersLoadSuccess(orders)),
    );
  }
}
