import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_state.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/new_orders_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/new_orders_cubit_states.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/widgets/sub_category_card_custom.dart';

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
        TempTabBarForTest<String>(
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
        // Expanded must wrap the FutureBuilder
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

/// A combined widget for testing main categories as a horizontal scrollable tab bar.
/// Works with static data.
class TempTabBarForTest<T> extends StatefulWidget {
  final List<T> items; // Dynamic items (String, int, or model)
  final Function(T value) onChange; // Callback when an item is selected
  final String Function(T item)? labelBuilder; // Optional label extractor
  final int initialIndex;

  const TempTabBarForTest({
    super.key,
    required this.items,
    required this.onChange,
    this.labelBuilder,
    this.initialIndex = 0,
  });

  @override
  State<TempTabBarForTest<T>> createState() => _TempTabBarForTestState<T>();
}

class _TempTabBarForTestState<T> extends State<TempTabBarForTest<T>> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, i) {
          final item = widget.items[i];

          // If the item is an object, allow a custom label builder
          final label = widget.labelBuilder != null
              ? widget.labelBuilder!(item)
              : item.toString();

          return ChipCustom(
            title: label,
            isSelected: i == _selectedIndex,
            onTap: () {
              setState(() => _selectedIndex = i);
              widget.onChange(item);
            },
          );
        },
      ),
    );
  }
}

// SubCustomTabBar(
//   length: 4,
//   tabs: [
//     Tab(
//       child: Text(
//         'الكل',
//         style:
//             Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
//       ),
//     ),
//     Tab(
//       child: Text(
//         'بدون فاتورة',
//         maxLines: 2,
//         style: Theme.of(context).textTheme.titleMedium!,
//       ),
//     ),
//     Tab(
//       child: Text(
//         'لم تسدد',
//         style: Theme.of(context).textTheme.titleMedium!,
//       ),
//     ),
//     Tab(
//       child: Text(
//         'للشحن',
//         style: Theme.of(context).textTheme.titleMedium!,
//       ),
//     ),
//   ],
//   tabViews: [
//     //All TabViews
// AllInfoOrder(),
//     //NoBill TabViews
//     NoBillInfoOrder(),
//     //NotPaid TabViews
//     NoPaidInfoOrder(),
//     //Shipping TabViews
//     ShippingInfoOrder(),
//   ],
// ),

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
