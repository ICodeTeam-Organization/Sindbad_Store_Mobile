import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/Colors.dart';

class ImageCardCustom extends StatelessWidget {
  const ImageCardCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
        // Product Image
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(8),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: AppColors.background,
        //       borderRadius: BorderRadius.circular(8),
        //       border:
        //           Border.all(width: 1, color: AppColors.greyDark),
        //     ),
        //     child: SizedBox(
        //       width: double
        //           .infinity, // عرض يأخذ المساحة المتاحة بالكامل
        //       height: double
        //           .infinity, // ارتفاع يأخذ المساحة المتاحة بالكامل
        //       child: FittedBox(
        //         fit: BoxFit.cover,
        //         child: SvgPicture.asset(
        //           "assets/image_example.svg",
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 70.h,
        width: 70.w,
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: AppColors.greyDark)),
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
      ),
    );
  }
}
