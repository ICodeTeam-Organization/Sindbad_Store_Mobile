import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class CustomTabBarWidget extends StatelessWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final int length;
  final Color indicatorColor;
  final double indicatorWeight;
  final Color labelColor;
  final Color unselectedLabelColor;
  final double height;

  const CustomTabBarWidget({super.key, 
    required this.tabs,
    required this.tabViews,
    required this.length,
    this.indicatorColor = AppColors.redDark,
    this.indicatorWeight = 4.0,
    this.labelColor = AppColors.black,
    this.unselectedLabelColor =AppColors.black,
    this.height = 500.0,
  }) : assert(tabs.length == tabViews.length, 'Tabs and TabViews must have the same length'),
       assert(length == tabs.length, 'Length must match the number of tabs and tab views');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            indicatorColor: indicatorColor,
            indicatorWeight: indicatorWeight.w,
            labelColor: labelColor,
            unselectedLabelColor: unselectedLabelColor,
            tabs: tabs,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              height: height.h,
              child: TabBarView(
                children: tabViews,
              ),
            ),
          ),
        ],
      ),
    );
  }
}