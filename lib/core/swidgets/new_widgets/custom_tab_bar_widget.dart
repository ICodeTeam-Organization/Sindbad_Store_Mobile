import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';

import '../../../config/styles/text_style.dart';

TabController? tabController;

class CustomTabBarWidget extends StatefulWidget {
  final List<Widget> tabs;
  final List<Widget> tabViews;
  final int length;
  final Color indicatorColor;
  final double indicatorWeight;
  final Color labelColor;
  final Color unselectedLabelColor;
  final double height;
  final double heightTab;

  // Constants for repeated values
  static const double _borderRadius = 25.0;
  static const double _indicatorPadding = 5.0;
  static const double _sizedBoxHeight = 5.0;

  /// Creates a custom tab bar widget.
  ///
  /// The [tabs] and [tabViews] lists must have the same length.
  /// The [length] parameter must match the number of tabs and tab views.

  const CustomTabBarWidget({
    super.key,
    required this.tabs,
    required this.tabViews,
    required this.length,
    this.indicatorColor = Colors.transparent,
    this.indicatorWeight = 2.0,
    this.labelColor = AppColors.black,
    this.unselectedLabelColor = AppColors.black,
    this.height = 700.0,
    this.heightTab = 65,
  })  : assert(tabs.length == tabViews.length,
            'Tabs and TabViews must have the same length'),
        assert(length == tabs.length,
            'Length must match the number of tabs and tab views');

  @override
  State<CustomTabBarWidget> createState() => _CustomTabBarWidgetState();
}

class _CustomTabBarWidgetState extends State<CustomTabBarWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    //  tabController = TabController(length: widget.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: AppColors.colorButton,
                  borderRadius: BorderRadius.circular(25)),
              child: SizedBox(
                height: 60.h,
                child: TabBar(
                  //  controller: tabController,
                  labelStyle: KTextStyle.textStyle16
                      .copyWith(fontWeight: FontWeight.bold),
                  dividerColor: Colors.transparent,
                  indicatorColor: widget.indicatorColor,
                  indicatorWeight: widget.indicatorWeight.w,
                  labelColor: widget.labelColor,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: 0), // تقليل المسافة بين العناوين
                  unselectedLabelColor: widget.unselectedLabelColor,
                  tabs: widget.tabs,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        CustomTabBarWidget._borderRadius.r),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                      horizontal: CustomTabBarWidget._indicatorPadding.h,
                      vertical: CustomTabBarWidget._indicatorPadding.w),
                  // Circular splash effect for tap feedback
                  splashFactory: InkSparkle.splashFactory,
                  splashBorderRadius:
                      BorderRadius.circular(CustomTabBarWidget._borderRadius.r),
                  // Custom overlay color for tap/hover states
                  // overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  //   (Set<MaterialState> states) {
                  //     if (states.contains(MaterialState.pressed)) {
                  //       return Colors.white.withOpacity(0.1);
                  //     }
                  //     if (states.contains(MaterialState.hovered)) {
                  //       return Colors.white.withOpacity(0.05);
                  //     }
                  //     return null;
                  //   },
                  // ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: CustomTabBarWidget._sizedBoxHeight.h,
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              child: TabBarView(
                // controller: tabController,
                children: widget.tabViews,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
