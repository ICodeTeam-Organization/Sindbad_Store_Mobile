// =================  Start Sub Category Card =====================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/styles/Colors.dart';
import '../../../../../../core/styles/text_style.dart';

class ChipCustom extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onTap;

  const ChipCustom(
      {super.key, required this.title, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyBorder,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            title,
            style: KTextStyle.textStyle14,
          ),
        ),
      ),
    );
  }
}
