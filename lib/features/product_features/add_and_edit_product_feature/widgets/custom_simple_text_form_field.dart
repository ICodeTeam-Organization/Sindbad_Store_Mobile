import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

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
    return SizedBox(
      width: width.w,
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
