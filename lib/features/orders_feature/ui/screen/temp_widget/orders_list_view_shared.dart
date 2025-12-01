import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/order%20cubit/orders_cubit_states.dart';
import 'package:sindbad_management_app/core/swidgets/no_data_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_body.dart';

typedef ItemBuilder = Widget Function(
    BuildContext context, int index, dynamic item);

class OrdersListView extends StatefulWidget {
  final List<int> statuses;
  final bool isUrgent;
  // final int status;
  final int pageSize;
  // final bool isUrgent;
  // final ItemBuilder itemBuilder;

  const OrdersListView({
    super.key,
    required this.statuses,
    required this.isUrgent,
    // required this.status,
    required this.pageSize,
    // this.isUrgent = false,
    // required this.itemBuilder,
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

    await context.read<OrdersCubit>().fetchAllOrders(
          widget.statuses,
          widget.isUrgent,
          pageNumber,
          widget.pageSize,
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
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is OrdersLoadSuccess) {
          setState(() {
            if (pageNumber == 1) {
              orders = state.orders;
              // Clear animated indices on refresh to trigger animations
              _animatedIndices.clear();
            } else {
              orders.addAll(state.orders);
            }
          });
        } else if (state is OrdersLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        // Use the Shimmer loading when the initial page is loading.
        if (state is OrdersLoadInProgress && pageNumber == 1) {
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
          return NoDataWidget();
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
                      if (index == orders.length - 1)
                        SizedBox(
                          height: 120.h,
                        ),
                    ],
                  ),
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

/// Widget that animates each order item with a smooth fade-in and slide-up effect
class AnimatedOrderItem extends StatefulWidget {
  final int index;
  final Widget child;
  final bool animate;

  const AnimatedOrderItem({
    super.key,
    required this.index,
    required this.child,
    this.animate = true,
  });

  @override
  State<AnimatedOrderItem> createState() => _AnimatedOrderItemState();
}

class _AnimatedOrderItemState extends State<AnimatedOrderItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.animate) {
      // Stagger animation based on index for a cascading effect
      // Limit to first 10 items to avoid long delays
      final delay = (widget.index % 10) * 80;
      Future.delayed(Duration(milliseconds: delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    } else {
      // If not animating, go straight to the end state
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
