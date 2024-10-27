import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class ActionButtonOrderCancle extends StatelessWidget {
  const ActionButtonOrderCancle({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 30.h,
        width: 60.w,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(25.r)),
        child: Text(
          title,
          style: const TextStyle(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
