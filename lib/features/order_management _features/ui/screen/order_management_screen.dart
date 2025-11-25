import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../../core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../config/styles/text_style.dart';
import 'before_tab_views.dart';
import 'canceled_tab_views.dart';
import 'new_orders_tap.dart';
import 'urgent_tab_views/urgent_tab_views.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});
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
                        textAlign:
                            TextAlign.center, // matches text-align: center
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
                  //Urgent TabViews
                  UrgentTabViews(),
                  //Before TabViews
                  BeforeTabViews(),
                  //Canceled TabViews
                  CanceledTabViews(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
