// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import '../../../domain/usecases/all_order_usecase.dart';
import 'all_order_state.dart';

class AllOrderCubit extends Cubit<AllOrderState> {
  AllOrderCubit(this.allOrderUseCase)
      : super(
          AllOrderInitial(),
        );
  final AllOrderUsecase allOrderUseCase;
  Future<void> fetchAllOrder(
      int pageSize, int orderDetailStatus, String srearchKeyword, bool isUrgen,
      {int pageNumber = 1}) async {
    emit(
      AllOrderLoading(),
    );
    var result = await allOrderUseCase.execute(AllOrderParam(
      pageNumber,
      pageSize,
      orderDetailStatus,
      srearchKeyword,
      isUrgen,
    ));

    result.fold((failuer) {
      emit(
        AllOrderFailuer(errMessage: failuer.message),
      );
    }, (orders) {
      emit(
        AllOrderSuccess(orders: orders),
      );
    });
  }
}
