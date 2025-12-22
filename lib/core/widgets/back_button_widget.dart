import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    required this.iconBgColor,
    required this.widget,
    required this.iconColor,
  });

  final Color iconBgColor;
  final CustomAppBar widget;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 15.w),
      child: Material(
        color: iconBgColor,
        borderRadius: BorderRadius.circular(12.r),
        child: InkWell(
          onTap: widget.onBackPressed ?? () => context.pop(),
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20.w,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
