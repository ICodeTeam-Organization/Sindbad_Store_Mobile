import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

TabController? subTabController;

class SubCustomTabBar extends StatefulWidget {
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
  State<SubCustomTabBar> createState() => _SubCustomTabBarState();
}

class _SubCustomTabBarState extends State<SubCustomTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    subTabController = TabController(length: widget.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(25.r)),
              child: TabBar(
                controller: subTabController,
                padding: EdgeInsets.zero,
                labelStyle: KTextStyle.textStyle16,
                dividerColor: Colors.transparent,
                indicatorColor: widget.indicatorColor,
                indicatorWeight: widget.indicatorWeight.w,
                labelColor: widget.labelColor,
                unselectedLabelColor: widget.unselectedLabelColor,
                tabs: widget.tabs,
                indicator: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1.5.w),
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(SubCustomTabBar._borderRadius.r),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(
                    horizontal: SubCustomTabBar._indicatorPadding.h,
                    vertical: SubCustomTabBar._indicatorPadding.w),
              ),
            ),
            SizedBox(
              height: SubCustomTabBar._sizedBoxHeight.h,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: SizedBox(
                child: TabBarView(
                  controller: subTabController,
                  children: widget.tabViews,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
