import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/custom_search_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_tap_bar_widget.dart';
import 'package:sindbad_management_app/store_app_features/home/ui/widget/store_home_page_list_view_widget.dart';

class StoreHomePageOrderWidget extends StatelessWidget {
  const StoreHomePageOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          KCustomSearchWidget(hintText: "بحث برقم الطلب: "),
          CustomTabBarWidget(tabs: [
            Tab(
              child: Text(
                "جديدة",
                style: KTextStyle.tabs,
              ),
            ),
            Tab(
              child: Text("مستعجلة",
                  style: KTextStyle.tabs.copyWith(fontSize: 15)),
            ),
            Tab(
              child: Text(
                "سابقة",
                style: KTextStyle.tabs,
              ),
            ),
            Tab(
              child: Text(
                "ملغية",
                style: KTextStyle.tabs,
              ),
            ),
          ], tabViews: const [
            //New
            StoreHomePageListViewWidget(
              bondNum: '654654',
              date: '2024/10/2',
              itemNum: '1',
            ),
            //Quaick
            StoreHomePageListViewWidget(
              bondNum: '654654',
              date: '2024/10/2',
              itemNum: '2',
            ),
            //Before
            StoreHomePageListViewWidget(
              bondNum: '654654',
              date: '2024/10/2',
              itemNum: '3',
            ),
            //Cancled
            StoreHomePageListViewWidget(
              bondNum: '654654',
              date: '2024/10/2',
              itemNum: '4',
            ),
          ], length: 4),
        ],
      ),
    );
  }
}
