import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class ActionButtonWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool? isSolid;
  const ActionButtonWidget({super.key, required this.icon, required this.title, this.isSolid = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: isSolid == true ?
      BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(5)
      ):
      BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColors.primary,)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(title),
        ],
      ),
    );
  }
}