import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';
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

    // TODO: Uncomment when API is ready
    // final result = await _orderUseCase.execute(
    //   OrderParam(
    //     statuses: statusList,
    //     pageNumber: page,
    //     pageSize: size,
    //   ),
    // );

    // ===== MOCK DATA FOR TESTING PAGINATION =====
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final random = Random();
    const totalPages = 5; // Simulate 5 pages total (50 items)

    // Generate mock orders for this page
    final List<AllOrderEntity> mockOrders = List.generate(size, (index) {
      final itemIndex = ((page - 1) * size) + index;
      final orderId = 1000 + itemIndex;
      final packageId = 5000 + itemIndex;
      final productCount = random.nextInt(25) + 1;
      final day = random.nextInt(28) + 1;
      final month = random.nextInt(12) + 1;
      final statuses = ['2', '3', '4', '5', '6'];
      final payStatuses = ['2', '3', '4', '5', '6'];

      return AllOrderEntity(
        idOrder: orderId,
        idPackage: packageId,
        orderNum: "ORD-2025-${orderId.toString().padLeft(4, '0')}",
        orderBill: "BILL-${(5500 + itemIndex).toString()}",
        productMount: productCount.toString(),
        orderStatuse: statuses[random.nextInt(statuses.length)],
        payStatus: payStatuses[random.nextInt(payStatuses.length)],
        orderDates:
            "2025-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
      );
    });

    _isLoading = false;

    // Simulate hasMore based on current page
    final hasMore = page < totalPages;

    emit(OrdersLoadSuccess(
      mockOrders,
      currentPage: page,
      hasMore: hasMore,
    ));
    // ===== END MOCK DATA =====
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

    // TODO: Uncomment when API is ready
    // final result = await _orderUseCase.execute(
    //   OrderParam(
    //     statuses: statusList,
    //     pageNumber: nextPage,
    //     pageSize: _pageSize,
    //   ),
    // );

    // ===== MOCK DATA FOR TESTING PAGINATION =====
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    final random = Random();
    const totalPages = 5; // Simulate 5 pages total (50 items)

    // Generate mock orders for this page
    final List<AllOrderEntity> newOrders = List.generate(_pageSize, (index) {
      final itemIndex = ((nextPage - 1) * _pageSize) + index;
      final orderId = 1000 + itemIndex;
      final packageId = 5000 + itemIndex;
      final productCount = random.nextInt(25) + 1;
      final day = random.nextInt(28) + 1;
      final month = random.nextInt(12) + 1;
      final statuses = ['2', '3', '4', '5', '6'];
      final payStatuses = ['2', '3', '4', '5', '6'];

      return AllOrderEntity(
        idOrder: orderId,
        idPackage: packageId,
        orderNum: "ORD-2025-${orderId.toString().padLeft(4, '0')}",
        orderBill: "BILL-${(5500 + itemIndex).toString()}",
        productMount: productCount.toString(),
        orderStatuse: statuses[random.nextInt(statuses.length)],
        payStatus: payStatuses[random.nextInt(payStatuses.length)],
        orderDates:
            "2025-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
      );
    });

    _isLoading = false;

    // Simulate hasMore based on current page
    final hasMore = nextPage < totalPages;

    _currentPage = nextPage;
    final allOrders = [...currentState.orders, ...newOrders];
    emit(OrdersLoadSuccess(
      allOrders,
      currentPage: nextPage,
      hasMore: hasMore,
    ));
    // ===== END MOCK DATA =====
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
//Generate random orders
    final random = Random();
    final orderCount = random.nextInt(11) + 10; // Random 10-20 orders

    final statuses = [
      '2',
      '3',
      '4',
      '5',
      '6',
    ];
    final payStatuses = ['2', '3', '4', '5', '6'];

    final List<AllOrderEntity> orders = List.generate(orderCount, (index) {
      final orderId = random.nextInt(10000) + 1;
      final packageId = random.nextInt(5000) + 100;
      final productCount = random.nextInt(25) + 1;
      final day = random.nextInt(28) + 1;
      final month = random.nextInt(12) + 1;

      return AllOrderEntity(
        idOrder: orderId,
        idPackage: packageId,
        orderNum: "ORD-2025-${orderId.toString().padLeft(4, '0')}",
        orderBill: "BILL-${(5500 + index).toString()}",
        productMount: productCount.toString(),
        orderStatuse: statuses[random.nextInt(statuses.length)],
        payStatus: payStatuses[random.nextInt(payStatuses.length)],
        orderDates:
            "2025-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}",
      );
    });

    await Future.delayed(const Duration(seconds: 1));
    emit(OrdersLoadSuccess(orders));
  }
}
