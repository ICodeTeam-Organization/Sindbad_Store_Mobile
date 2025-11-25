import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/orders_features/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/all_order_state.dart';
import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/new_orders_cubit.dart';
import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/new_orders_cubit_states.dart';
import 'package:sindbad_management_app/features/orders_features/ui/screen/temp_widget/animated_order_item.dart';
import 'package:sindbad_management_app/features/orders_features/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/orders_features/ui/widget/package_status_filterBar.dart';

class NewTabViews extends StatefulWidget {
  const NewTabViews({super.key});

  @override
  State<NewTabViews> createState() => _NewTabViewsState();
}

class _NewTabViewsState extends State<NewTabViews> {
  // Track which items have been animated
  final Set<int> _animatedIndices = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PackageStatusFilterBar<String>(
          items: [
            PackageStatus.all.displayName,
            PackageStatus.packageConfirmedByYemeniAccountant.displayName,
            PackageStatus.packageInvoiceCreated.displayName,
            PackageStatus.packageShippedFromStore.displayName,
          ],
          onChange: (value) {
            context
                .read<NewOrdersCubit>()
                .fetchOrders(PackageStatusExtension.idFromDisplayName(value));
          },
        ),
        Expanded(
          child: BlocConsumer<NewOrdersCubit, NewOrdersState>(
            builder: (context, state) {
              if (state is NewOrdersLoadInProgress) {
                return Center(
                    child: SizedBox(
                        height: 35,
                        width: 35,
                        child: CircularProgressIndicator()));
              }
              if (state is NewOrdersLoadSuccess) {
                if (state.orders.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(25.r),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/no_data.png',
                              height: 80.h,
                              width: 80.w,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'توجد بيانات حاليا',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "لا توجد بيانات",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: state.orders.length,
                    itemBuilder: (context, index) {
                      if (index < state.orders.length) {
                        // Mark this index as needing animation
                        final shouldAnimate = !_animatedIndices.contains(index);
                        if (shouldAnimate) {
                          _animatedIndices.add(index);
                        }

                        return AnimatedOrderItem(
                          index: index,
                          animate: shouldAnimate,
                          child: Column(
                            children: [
                              OrderBody(
                                billNumber: state.orders[index].orderBill,
                                orderNumber: state.orders[index].orderNum,
                                date: state.orders[index].orderDates,
                                itemNumber: state.orders[index].productMount,
                                paymentInfo: state.orders[index].payStatus,
                                orderStatus: state.orders[index].orderStatuse,
                                idOrder: state.orders[index].idOrder,
                                idPackage: state.orders[index].idPackage,
                              ),
                              if (index == state.orders.length - 1)
                                SizedBox(height: 120.h),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                            child: SizedBox(
                                height: 35,
                                width: 35,
                                child: CircularProgressIndicator()));
                      }
                    },
                  );
                }
              } else if (state is NewOrdersLoadFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(25.r),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image_loading.png',
                            height: 80.h,
                            width: 80.w,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'هناك خطأ الرجاء المحاولة لاحقاً',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Center(
                  child: SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator()));
            },
            listener: (context, state) {
              // Clear animated indices when new data loads to ensure animations play
              if (state is NewOrdersLoadSuccess) {
                setState(() {
                  _animatedIndices.clear();
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

class OrdersListView extends StatefulWidget {
  final List<int> statuses;
  final bool isUrgent;
  final int pageSize;

  const OrdersListView({
    super.key,
    required this.statuses,
    required this.isUrgent,
    required this.pageSize,
  });

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  bool isFetching = false;
  int pageNumber = 1;
  List<dynamic> orders = [];

  // Track which items have been animated
  final Set<int> _animatedIndices = {};

  @override
  void initState() {
    super.initState();
    _fetchOrders();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchOrders({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        pageNumber = 1;
        orders.clear();
      });
    }
    if (isFetching) return;
    setState(() => isFetching = true);

    await context.read<AllOrderCubit>().fetchAllOrder(
          statuses: widget.statuses,
          isUrgent: widget.isUrgent,
          pageNumber: pageNumber,
          pageSize: widget.pageSize,
        );

    setState(() => isFetching = false);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        0.7 * _scrollController.position.maxScrollExtent) {
      pageNumber++;
      _fetchOrders();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllOrderCubit, AllOrderState>(
      listener: (context, state) {
        if (state is AllOrderSuccess) {
          setState(() {
            if (pageNumber == 1) {
              orders = state.orders;
              // Clear animated indices on refresh to trigger animations
              _animatedIndices.clear();
            } else {
              orders.addAll(state.orders);
            }
          });
        } else if (state is AllOrderFailuer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AllOrderLoading && pageNumber == 1) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 6,
              itemBuilder: (context, index) => ListTile(
                title: Container(
                  color: Colors.white,
                  height: 130.h,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        }

        if (orders.isEmpty) {
          return const Center(
            child: Text(
              "لا توجد طلبات",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _fetchOrders(isRefresh: true),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: orders.length + (isFetching ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < orders.length) {
                // Mark this index as needing animation
                final shouldAnimate = !_animatedIndices.contains(index);
                if (shouldAnimate) {
                  _animatedIndices.add(index);
                }

                return AnimatedOrderItem(
                  index: index,
                  animate: shouldAnimate,
                  child: Column(
                    children: [
                      OrderBody(
                        billNumber: orders[index].orderBill,
                        orderNumber: orders[index].orderNum,
                        date: orders[index].orderDates,
                        itemNumber: orders[index].productMount,
                        paymentInfo: orders[index].payStatus,
                        orderStatus: orders[index].orderStatuse,
                        idOrder: orders[index].idOrder,
                        idPackage: orders[index].idPackage,
                      ),
                      if (index == orders.length - 1) SizedBox(height: 120.h),
                    ],
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
