// ================= Button Custom ================

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 90.w,
        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 8.0.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary, // لون الحدود
            width: 1.0, // سماكة الحدود
          ),
          borderRadius: BorderRadius.circular(8.0), // استدارة الحواف
          color: AppColors.white, // لون الخلفية
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.red, // لون الأيقونة
              size: 16.w, // حجم الأيقونة
            ),
            SizedBox(width: 6.w), // مسافة بين النص والأيقونة
            Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.greyDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
