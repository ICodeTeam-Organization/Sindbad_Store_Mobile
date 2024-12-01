import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_detalis_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_details_usecase.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(this.orderDetailsUsecase) : super(OrderDetailsInitial());
  final OrderDetailsUsecase orderDetailsUsecase;
  Future<void> fetchOrderDetails(
      int orderId,
      String orderNumber,
      String billNumber,
      String clock,
      String date,
      String itemNumber,
      String paymentInfo,
      String orderStatus) async {
    emit(
      OrderDetailsLoading(),
    );
    var result = await orderDetailsUsecase.execute(
      OrderDetailsParam(
          orderId: orderId,
          orderNumber: orderNumber,
          billNumber: billNumber,
          clock: clock,
          date: date,
          itemNumber: itemNumber,
          paymentInfo: paymentInfo,
          orderStatus: orderStatus),
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
