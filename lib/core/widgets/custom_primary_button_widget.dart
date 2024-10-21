import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class KCustomPrimaryButtonWidget extends StatelessWidget {
  const KCustomPrimaryButtonWidget({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.width=100,

    this.height=17,


    this.buttonColor = AppColors.redAccentColor ,
    this.textColor = AppColors.white ,
});

  final String buttonName;
  final Color buttonColor;
  final Color textColor;
  final GestureTapCallback onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width.w,
        height: height.h,
        // color: buttonColor,
        decoration: BoxDecoration(
            color: buttonColor,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: 
          KTextStyle.buttonScreen.copyWith(
              color: textColor,

          ) 
          // TextStyle(
          //   color: Colors.white,
          //   fontSize: 16.sp,
          //   fontWeight: FontWeight.bold
          //   ),
        ),
      ),
    );
  }
}