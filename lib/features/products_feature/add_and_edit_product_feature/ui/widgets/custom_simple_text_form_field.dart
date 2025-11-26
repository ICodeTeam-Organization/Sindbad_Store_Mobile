import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CustomSimpleTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final double width;
  final double height;

  const CustomSimpleTextFormField({
    super.key,
    required this.textController,
    this.hintText = "",
    this.width = 130.0,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    bool ifSmallScreen = widthScreen == 360;

    return SizedBox(
      width: ifSmallScreen ? 100.w : width.w,
      height: height.h,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          style: KTextStyle.textStyle14,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors.primaryBackground, width: 1.w),
            ),
          ),
          controller: textController,
        ),
      ),
    );
  }
}
