import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class SubCustomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final int length;
  final Color indicatorColor;
  final double indicatorWeight;
  final Color labelColor;
  final Color unselectedLabelColor;
  final double height;

  // Constants for repeated values
  static const double _borderRadius = 25.0;
  static const double _indicatorPadding = 5.0;
  static const double _sizedBoxHeight = 5.0;

  /// Creates a custom tab bar widget.
  ///
  /// The [tabs] and [tabViews] lists must have the same length.
  /// The [length] parameter must match the number of tabs and tab views.

  const SubCustomTabBar({
    super.key,
    required this.tabs,
    required this.tabViews,
    required this.length,
    this.indicatorColor = Colors.transparent,
    this.indicatorWeight = 2.0,
    this.labelColor = AppColors.black,
    this.unselectedLabelColor = AppColors.black,
    this.height = 700.0,
  })  : assert(tabs.length == tabViews.length,
            'Tabs and TabViews must have the same length'),
        assert(length == tabs.length,
            'Length must match the number of tabs and tab views');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25.r)),
            child: TabBar(
              padding: EdgeInsets.zero,
              labelStyle: KTextStyle.textStyle16,
              dividerColor: Colors.transparent,
              indicatorColor: indicatorColor,
              indicatorWeight: indicatorWeight.w,
              labelColor: labelColor,
              unselectedLabelColor: unselectedLabelColor,
              tabs: tabs,
              indicator: BoxDecoration(
                border: Border.all(color: AppColors.grey, width: 2.w),
                color: Colors.white,
                borderRadius: BorderRadius.circular(_borderRadius.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(
                  horizontal: _indicatorPadding.h,
                  vertical: _indicatorPadding.w),
            ),
          ),
          SizedBox(
            height: _sizedBoxHeight.h,
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
