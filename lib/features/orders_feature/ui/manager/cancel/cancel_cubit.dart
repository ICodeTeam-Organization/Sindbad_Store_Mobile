import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/order_cancel_usecase.dart';
import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/order_cancel_entity.dart';
part 'cancel_state.dart';

class CancelCubit extends Cubit<CancelState> {
  CancelCubit(this.orderCancelUsecase) : super(CancelInitial());
  final OrderCancelUsecase orderCancelUsecase;
  Future<void> fetchOrderCancel({
    required int orderId,
    required bool orderCancel,
    required String reasonCancel,
  }) async {
    emit(CancelInitial());
    try {
      var params = OrderCancelParam(
        orderId: orderId,
        orderCancel: orderCancel,
        reasonCancel: reasonCancel,
      );
      final result = await orderCancelUsecase.execute(params);
      result.fold((failure) => emit(CancelFailure(errMessage: failure.message)),
          (serverMessage) {
        if (serverMessage.isSuccess == true) {
          emit(CancelSuccess(serverMessage: serverMessage));
        } else {
          emit(CancelFailure(errMessage: serverMessage.serverMessage));
        }
      });
    } catch (e) {
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(CancelFailure(errMessage: failure.message));
      } else {
        emit(CancelFailure(errMessage: e.toString()));
      }
    }
  }
}
