import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_features/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/orders_features/domain/usecases/order_details_usecase.dart';
part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this.orderDetailsUsecase) : super(OrderDetailsInitial());
  final OrderDetailsUsecase orderDetailsUsecase;
  Future<void> fetchOrderDetails(
    int packageId,
  ) async {
    emit(
      OrderDetailsLoading(),
    );
    var result = await orderDetailsUsecase.execute(
      OrderDetailsParam(
        packageId: packageId,
      ),
    );

    result.fold((failuer) {
      emit(
        OrderDetailsFailure(errMessage: failuer.message),
      );
    }, (orderDetails) {
      emit(
        OrderDetailsSuccess(orderDetails: orderDetails),
      );
    });
  }
}
