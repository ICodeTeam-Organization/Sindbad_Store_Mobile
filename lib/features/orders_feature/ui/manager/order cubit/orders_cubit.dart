import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_param.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final NewOrderUsecase _orderUseCase;

  // Pagination state
  int _currentPage = 1;
  int _currentStatus = 0;
  bool _isLoading = false;
  static const int _pageSize = 10;

  OrdersCubit(this._orderUseCase) : super(OrdersInitial());

  void fetchOrders(int status, {int page = 1, int size = 10}) async {
    // Prevent multiple simultaneous requests
    if (_isLoading) return;
    _isLoading = true;

    // Reset pagination when status changes or fresh fetch
    _currentPage = page;
    _currentStatus = status;

    emit(OrdersLoadInProgress());

    List<int> statusList;

    if (status == PackageStatus.all.id) {
      // Fetch all statuses of the order
      statusList = [2, 3, 4];
    } else {
      // Fetch only the selected status
      statusList = [status];
    }

    final result = await _orderUseCase.execute(
      OrderParam(
        statuses: statusList,
        pageNumber: page,
        pageSize: size,
      ),
    );

    _isLoading = false;

    result.fold(
      (failure) => emit(OrdersLoadFailure(failure.toString())),
      (orders) => emit(OrdersLoadSuccess(
        orders,
        currentPage: page,
        hasMore: orders.length == size, // hasMore if we got a full page
      )),
    );
  }

  void loadMoreOrders() async {
    final currentState = state;
    if (currentState is! OrdersLoadSuccess ||
        _isLoading ||
        !currentState.hasMore) {
      return;
    }

    _isLoading = true;
    final nextPage = _currentPage + 1;

    emit(OrdersLoadMoreInProgress(currentState.orders, _currentPage));

    List<int> statusList;
    if (_currentStatus == PackageStatus.all.id) {
      statusList = [2, 3, 4];
    } else {
      statusList = [_currentStatus];
    }

    final result = await _orderUseCase.execute(
      OrderParam(
        statuses: statusList,
        pageNumber: nextPage,
        pageSize: _pageSize,
      ),
    );

    _isLoading = false;

    result.fold(
      (failure) => emit(OrdersLoadFailure(failure.toString())),
      (newOrders) {
        _currentPage = nextPage;
        final allOrders = [...currentState.orders, ...newOrders];
        emit(OrdersLoadSuccess(
          allOrders,
          currentPage: nextPage,
          hasMore:
              newOrders.length == _pageSize, // hasMore if we got a full page
        ));
      },
    );
  }

  void fetchUrgentOrders(int status) async {
    emit(OrdersLoadInProgress());

    List<int> statusList;

    // If user selected "Call"

    if (status == PackageStatus.all.id) {
      // Fetch all statuses of the order                            
      statusList = [2, 3, 4];
    } else {
      // Fetch only the selected status
      statusList = [status];
    }

    final result = await _orderUseCase.execute(
      OrderParam(
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

  Future<void> fetchAllOrders(
      List<int> status, bool isUrgent, int pageNumber, int pageSize) async {
    emit(OrdersLoadInProgress());

    final result = await _orderUseCase.execute(
      OrderParam(
        statuses: status,
        isUrgent: isUrgent,
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

    result.fold(
      (failure) => emit(OrdersLoadFailure(failure.toString())),
      (orders) => emit(OrdersLoadSuccess(
        orders,
        currentPage: pageNumber,
        hasMore: orders.length == pageSize,
      )),
    );
  }
}
