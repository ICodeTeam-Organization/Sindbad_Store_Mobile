import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/all_order_state.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/order%20cubit/orders_cubit_states.dart';
import 'package:sindbad_management_app/core/swidgets/no_data_widget.dart';
import 'package:sindbad_management_app/core/swidgets/error_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/screen/temp_widget/animated_order_item.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/package_status_filterBar.dart';

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
                .read<OrdersCubit>()
                .fetchOrders(PackageStatusExtension.idFromDisplayName(value));
          },
        ),
        Expanded(
          child: BlocConsumer<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoadInProgress) {
                return Center(
                    child: SizedBox(
                        height: 35,
                        width: 35,
                        child: CircularProgressIndicator()));
              }
              if (state is OrdersLoadSuccess) {
                if (state.orders.isEmpty) {
                  return NoDataWidget();
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
              } else if (state is OrdersLoadFailure) {
                return ErrorWidget(message: state.message);
              }
              return Center(
                  child: SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator()));
            },
            listener: (context, state) {
              // Clear animated indices when new data loads to ensure animations play
              if (state is OrdersLoadSuccess) {
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
