import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class KCustomSearchWidget extends StatelessWidget {
  String hintText;
  double width;
  double height;
  KCustomSearchWidget({
    super.key,
    required this.hintText,
    this.height = 37,
    this.width = 338,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      alignment: Alignment.center,
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(100.r)),
      child: TextFormField(
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(color: AppColors.white, width: 1.w)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(color: AppColors.white, width: 1.w)),
            suffixIcon: const Icon(Icons.search),
            hintText: hintText,
            hintStyle:
                KTextStyle.textStyle12.copyWith(color: AppColors.greyHint)),
      ),
    );
  }
}
