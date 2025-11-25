import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import '../new_orders_tap.dart';
import '../urgent_orders_tab.dart' hide OrdersListView;

class OrderManagementWidget extends StatelessWidget {
  const OrderManagementWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            CustomAppBar(
              tital: 'الطلبات',
              isBack: false,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: CustomTabBarWidget(
                length: 4,
                tabs: [
                  Tab(
                    child: Text('الجديدة',
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text('المستعجلة',
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text('السابقة',
                        style: TextTheme.of(context).titleMedium),
                  ),
                  Tab(
                    child: Text('الملغية',
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
