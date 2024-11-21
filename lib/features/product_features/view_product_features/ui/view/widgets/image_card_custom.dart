import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/Colors.dart';

class ImageCardCustom extends StatelessWidget {
  const ImageCardCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 75.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1.5.r, color: AppColors.greyDark)),
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          "assets/2.png",
          // width: 70.w,
          // height: 65.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
