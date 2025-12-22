import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : AppColors.blackDark;
    final bgColor =
        isDark ? Colors.grey[800]! : AppColors.grey.withOpacity(0.1);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onPressed?.call();
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            size: 26.w,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
