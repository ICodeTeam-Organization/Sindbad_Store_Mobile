import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class CustomInputWidget extends StatelessWidget {
  CustomInputWidget({
    super.key,
    this.height = 25,
    this.width = 200,
  });
  //String hintText;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      alignment: Alignment.center,
      width: width.w,
      height: height.h,
      color: AppColors.white,
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide(color: AppColors.white, width: 1.w)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide(color: AppColors.white, width: 1.w)),
        ),
      ),
    );
  }
}
