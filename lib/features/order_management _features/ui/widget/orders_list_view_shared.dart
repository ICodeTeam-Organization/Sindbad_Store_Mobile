import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_state.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';

typedef ItemBuilder = Widget Function(
    BuildContext context, int index, dynamic item);

class OrdersListView extends StatefulWidget {
  final bool isUrgen;
  final bool canceled;
  final bool delevred;
  final bool noInvoice;
  final bool unpaied;
  final bool paied;
  // final int status;
  final int pageSize;
  // final bool isUrgent;
  // final ItemBuilder itemBuilder;

  const OrdersListView({
    super.key,
    required this.isUrgen,
    required this.canceled,
    required this.delevred,
    required this.noInvoice,
    required this.unpaied,
    required this.paied,
    // required this.status,
    required this.pageSize,
    // this.isUrgent = false,
    // required this.itemBuilder,
  });

  @override
  State<OrdersListView> createState() => _OrdersListViewState();
}

class _OrdersListViewState extends State<OrdersListView> {
  final ScrollController _scrollController = ScrollController();

  bool isFetching = false;
  int pageNumber = 1;
  List<dynamic> orders = [];

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

    // Fetch the next page regardless of item count.
    // await context.read<MndHomeCubitCubit>().showOrderProduct(
    //       widget.status,
    //       widget.pageSize,
    //       pageNumber,
    //       widget.isUrgent,
    //     );
      await  context.read<AllOrderCubit>().fetchAllOrder(
          isUrgen: widget.isUrgen,
          canceled: widget.canceled,
          delevred: widget.delevred,
          noInvoice: widget.noInvoice,
          unpaied: widget.unpaied,
          paied: widget.paied,
          pageNumber: pageNumber,
          pageSize: widget.pageSize,
          // srearchKeyword: ''
        );

    setState(() => isFetching = false);
  }

  void _onScroll() {
    // Trigger next page fetch once user scrolls past 70%
    if (_scrollController.position.pixels >=
        0.7 * _scrollController.position.maxScrollExtent) {
      // Increase page number and fetch new page
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
            } else {
              orders.addAll(state.orders);
            }
          });
        } else if (state is AllOrderFailuer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errMessage), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        // Use the Shimmer loading when the initial page is loading.
        if (state is AllOrderLoading && pageNumber == 1) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 6,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    color: Colors.white,
                    height: 130.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            ),
          );
        }
        if (orders.isEmpty) {
          return const Center(
            child: Text("لا توجد طلبات",
                style: TextStyle(fontSize: 18, color: Colors.grey)),
          );
        }
        return RefreshIndicator(
          onRefresh: () => _fetchOrders(isRefresh: true),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: orders.length + (isFetching ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < orders.length) {
                // return widget.itemBuilder(context, index, orders[index]);
                return Column(
                children: [
                  OrderBody(
                    billNumber: orders[index].orderBill,
                    orderNumber: orders[index].orderNum,
                    date: orders[index].orderDates,
                    itemNumber: orders[index].productMount,
                    paymentInfo: orders[index].payStatus,
                    orderStatus: orders[index].orderStatuse,
                    idOrder: orders[index].idOrder,
                    idPackage:orders[index].idPackage,
                  ),
                  if (index == orders.length - 1)
                    SizedBox(
                      height: 120.h,
                    ),
                ],
              );
              } else {
                // Show a loading indicator at the bottom while fetching
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
