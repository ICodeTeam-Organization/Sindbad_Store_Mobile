import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../../core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../config/styles/text_style.dart';
import '../widget/order_management_widget/before_tab_views.dart';
import '../widget/order_management_widget/canceled_tab_views.dart';
import '../widget/order_management_widget/new_tab_views/new_tab_views.dart';
import '../widget/order_management_widget/urgent_tab_views/urgent_tab_views.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              CustomAppBar(
                isBack: false,
                tital: 'قائمة الطلبات',
              ),
              SizedBox(height: 5),
              Expanded(
                child: CustomTabBarWidget(
                  length: 4,
                  tabs: [
                    Tab(
                      child: Text(
                        'الجديدة',
                        textAlign:
                            TextAlign.center, // matches text-align: center
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          height: 1.0,
                          letterSpacing: 0.27,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text('المستعجلة', style: KTextStyle.textStyle16),
                    ),
                    Tab(
                      child: Text('السابقة', style: KTextStyle.textStyle16),
                    ),
                    Tab(
                      child: Text('الملغية', style: KTextStyle.textStyle16),
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
      ),
    );
  }
}
