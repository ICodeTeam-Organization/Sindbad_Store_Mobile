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
      // backgroundColor: AppColors.primaryBackground,
      centerTitle: true,
      title: Text(
        tital,
      ),
      actions: [
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          height: 50.h,
          width: 40.w,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey, width: 2),
              borderRadius: BorderRadius.circular(10),
              color: AppColors.primaryBackground),
          child: IconButton(
            onPressed: onPressed,
            padding: EdgeInsets.all(0),
            iconSize: 24,
            color: Colors.black54,
            icon: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
