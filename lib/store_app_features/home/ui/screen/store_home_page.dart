import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/store_app_features/home/ui/widget/store_home_page_item_widget.dart';
import 'package:sindbad_management_app/store_app_features/home/ui/widget/store_home_page_order_widget.dart';

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: TabBar(
              indicatorWeight: 4.w,
              dividerColor: AppColors.scaffColor,
              indicatorColor: AppColors.redDark,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.black,
              tabs: [
                Tab(
                  child: Text("الطلبات", style: KTextStyle.tabs),
                ),
                Tab(
                  child: Text(
                    "الاصناف",
                    style: KTextStyle.tabs,
                  ),
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            StoreHomePageOrderWidget(),
            ///////////////////////////
            StoreHomePageItemWidget()
          ],
        ),
      ),
    );
  }
}
