import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/widgets/no_data_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit_states.dart';

import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/package_status_filterBar.dart';

class UrgentTabViews extends StatelessWidget {
  const UrgentTabViews({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        PackageStatusFilterBar<PackageStatus>(
          items: [
            PackageStatus.all,
            PackageStatus.packageConfirmedByYemeniAccountant,
            PackageStatus.packageInvoiceCreated,
            PackageStatus.packageShippedFromStore,
          ],
          labelBuilder: (status) => status.getDisplayName(l10n),
          onChange: (status) {
            context.read<OrdersCubit>().fetchUrgentOrders(status.id);
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
                        return Column(
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
                return Center(
                  child: CardMesssageWidget(
                    logo: Image.asset(
                      'assets/image_loading.png',
                      height: 80.h,
                      width: 80.w,
                    ),
                    title: 'هناك خطأ الرجاء المحاولة لاحقاً',
                    subTitle: state.message,
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
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text("helping"),
              //     backgroundColor: Colors.red,
              //   ),
              // );
            },
          ),
        ),
        // Expanded must wrap the FutureBuilder
      ],
    );
  }
}
