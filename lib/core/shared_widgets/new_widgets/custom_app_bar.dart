import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/Colors.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    required this.tital,
    this.onPressed,
  });
  String tital;
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      centerTitle: true,
      title: Text(
        tital,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey, width: 2),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryBackground),
            child: IconButton(
              onPressed: onPressed,
              iconSize: 24,
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
