import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Theme-aware colors
    final bgColor = isDark ? Colors.grey[850] : AppColors.white;
    final borderColor = isDark ? Colors.grey[700]! : AppColors.greyBorder;
    final selectedBgColor = theme.colorScheme.primary;
    final unselectedBgColor = isDark ? Colors.grey[850] : AppColors.white;
    final selectedIconColor = Colors.white;
    final unselectedIconColor = theme.colorScheme.primary;
    final unselectedTextColor = isDark ? Colors.grey[400]! : AppColors.greyDark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.asMap().entries.map((entry) {
              int index = entry.key;
              CustomBottomNavigationBarItem item = entry.value;
              bool isSelected = currentIndex == index;

              return InkWell(
                onTap: () => onTap(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: 70.w,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? selectedBgColor : unselectedBgColor,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            item.icon,
                            height: 40.h,
                            width: 40.w,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? selectedIconColor
                                  : unselectedIconColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            style: isSelected
                                ? KTextStyle.textStyle12.copyWith(
                                    color: AppColors.white,
                                  )
                                : KTextStyle.textStyle12.copyWith(
                                    color: unselectedTextColor,
                                  ),
                            child: Text(
                              item.label,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBarItem {
  final String icon;
  final String label;

  CustomBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });
}
