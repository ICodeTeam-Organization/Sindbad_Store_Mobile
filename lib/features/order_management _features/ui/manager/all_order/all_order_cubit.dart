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
    required bool isUrgen,
    required bool canceled,
    required bool delevred,
    required bool noInvoice,
    required bool unpaied,
    required bool paied,
    required int pageNumber,
    required int pageSize,
    // required String storeId,
    // required String srearchKeyword,
  }) async {
    emit(
      AllOrderLoading(),
    );
    var result = await allOrderUseCase.execute(AllOrderParam(
      isUrgen: isUrgen,
      canceled: canceled,
      delevred: delevred,
      noInvoice: noInvoice,
      unpaied: unpaied,
      paied: paied,
      pageNumber: pageNumber,
      pageSize: pageSize,
      // storeId: storeId,
      // srearchKeyword: srearchKeyword
    ));

    result.fold((failuer) {
      emit(
        AllOrderFailuer(errMessage: failuer.message),
      );
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
