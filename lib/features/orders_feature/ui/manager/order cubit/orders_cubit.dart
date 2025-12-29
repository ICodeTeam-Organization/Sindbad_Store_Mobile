import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_feature/data/models/all_order_model/all_orders_model.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_param.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order cubit/orders_cubit_states.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final NewOrderUsecase _orderUseCase;

  // Pagination state
  int _currentPage = 1;
  int _currentStatus = 0;
  bool _isLoading = false;
  static const int _pageSize = 10;

  // Set to true to use mock data, false to use real API
  static const bool _useMockData = true;

  OrdersCubit(this._orderUseCase) : super(OrdersInitial());

  /// Generates a list of random mock orders for testing purposes.
  /// [count] - Number of orders to generate
  /// [simulateDelay] - Whether to simulate network delay (default: true)
  Future<List<OrderModel>> _generateMockOrders({
    required int count,
    bool simulateDelay = true,
  }) async {
    if (simulateDelay) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    final random = Random();
    final statusOptions = ['قيد المعالجة', 'تم الشحن', 'تم التسليم', 'ملغي'];
    final paymentOptions = ['مدفوع', 'غير مدفوع', 'دفع عند الاستلام'];

    return List.generate(count, (index) {
      final orderId = random.nextInt(90000) + 10000;
      final packageId = random.nextInt(1000) + 1;

      return OrderModel(
        orderId: orderId,
        packageId: packageId,
        orderNumber: 'ORD-$orderId',
        invoiceNumber: 'INV-${random.nextInt(99999) + 10000}',
        totalProducts: '${random.nextInt(10) + 1}',
        orderStatus: statusOptions[random.nextInt(statusOptions.length)],
        paymentStatus: paymentOptions[random.nextInt(paymentOptions.length)],
        orderDate: '2024/${random.nextInt(12) + 1}/${random.nextInt(28) + 1}',
        isDelevredOrCancled: random.nextBool(),
      );
    });
  }

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

    if (_useMockData) {
      // Use mock data for testing
      final mockOrders = await _generateMockOrders(count: size);
      _isLoading = false;
      emit(OrdersLoadSuccess(
        mockOrders,
        currentPage: page,
        hasMore: mockOrders.length == size,
      ));
      return;
    }

    // Use real API
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
        hasMore: orders.length == size,
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

    if (_useMockData) {
      // Use mock data for testing
      final mockOrders = await _generateMockOrders(count: _pageSize);
      _isLoading = false;
      _currentPage = nextPage;
      final allOrders = [...currentState.orders, ...mockOrders];
      emit(OrdersLoadSuccess(
        allOrders,
        currentPage: nextPage,
        hasMore: mockOrders.length == _pageSize,
      ));
      return;
    }

    // Use real API
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

    if (_useMockData) {
      // Use mock data for testing
      final mockOrders = await _generateMockOrders(count: 20);
      emit(OrdersLoadSuccess(mockOrders));
      return;
    }

    // Use real API
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

    if (_useMockData) {
      // Use mock data for testing
      final mockOrders = await _generateMockOrders(count: pageSize);
      emit(OrdersLoadSuccess(
        mockOrders,
        currentPage: pageNumber,
        hasMore: mockOrders.length == pageSize,
      ));
      return;
    }

    // Use real API
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
