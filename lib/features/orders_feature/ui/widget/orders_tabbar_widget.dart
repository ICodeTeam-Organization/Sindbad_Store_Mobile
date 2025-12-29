import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/orders_list_view_shared.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_tab_bar_widget.dart';
import '../screen/new_orders_tap.dart';
import '../screen/urgent_orders_tab.dart';

class OrderManagementWidget extends StatelessWidget {
  const OrderManagementWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            CustomAppBar(
              tital: l10n.orders,
              isBack: false,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: CustomTabBarWidget(
                length: 4,
                tabs: [
                  Tab(
                    child: Text(l10n.newOrders,
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text(l10n.urgentOrders,
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text(l10n.previousOrders,
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text(l10n.canceledOrders,
                        style: TextTheme.of(context).titleMedium),
                  ),
                ],
                tabViews: [
                  //New tabViews
                  NewTabViews(),

                  //Urgent TabViews (المستعجلة)
                  UrgentTabViews(),

                  //Before TabViews (السابقة)
                  OrdersListView(
                    statuses: [5, 6, 7],
                    isUrgent: false,
                    pageSize: 10,
                  ),

                  //Canceled TabViews (الملغية)
                  OrdersListView(
                    statuses: [8],
                    isUrgent: false,
                    pageSize: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
