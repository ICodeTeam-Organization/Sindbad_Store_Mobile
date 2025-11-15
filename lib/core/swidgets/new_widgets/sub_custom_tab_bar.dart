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

  static const double _borderRadius = 25.0;
  static const double _sizedBoxHeight = 5.0;

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
  void dispose() {
    subTabController?.dispose();
    subTabController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: TabBar(
              controller: subTabController,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              labelStyle: KTextStyle.textStyle16,
              dividerColor: Colors.transparent,

              // text colors
              labelColor: widget.labelColor,
              unselectedLabelColor: widget.unselectedLabelColor,

              // we disable TabBar's default indicator
              indicator: const BoxDecoration(),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.zero,

              tabs: List.generate(widget.tabs.length, (index) {
                return _AlwaysBorderTab(
                  index: index,
                  child: widget.tabs[index],
                  //    borderRadius: SubCustomTabBar._borderRadius.r,
                  controller: subTabController!,
                );
              }),
            ),
          ),
          SizedBox(height: SubCustomTabBar._sizedBoxHeight.h),
          Flexible(
            fit: FlexFit.loose,
            child: TabBarView(
              controller: subTabController,
              children: widget.tabViews,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlwaysBorderTab extends StatelessWidget {
  final Widget child;
  final int index;
  // final double borderRadius;
  final TabController controller;

  const _AlwaysBorderTab({
    required this.child,
    required this.index,
    //  required this.borderRadius,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.animation ?? controller,
      builder: (context, _) {
        final int selectedIndex =
            (controller.animation?.value ?? controller.index).round();

        final bool isSelected = selectedIndex == index;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1), // <-- spacing
          padding: EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            color: Colors.transparent, // no background
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? AppColors.primary : Color(0xffD9D9D9),
              width: 1.w,
            ),
          ),
          child: child,
        );
      },
    );
  }
}
