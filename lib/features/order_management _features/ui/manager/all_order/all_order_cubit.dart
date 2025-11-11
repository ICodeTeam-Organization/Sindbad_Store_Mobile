import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/all_order_usecase.dart';
import 'all_order_state.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  AllOrderCubit(this.allOrderUseCase)
      : super(
          AllOrderInitial(),
        );
  final AllOrderUsecase allOrderUseCase;
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
      if (orders.isNotEmpty) {
        emit(
          AllOrderSuccess(orders: orders),
        );
      } else {
        emit(
          AllOrderFailuer(errMessage: "لا توجد طلبات"),
        );
      }
    });
  }
}
