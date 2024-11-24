import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomTextFormWidget extends StatelessWidget {
  final TextEditingController textController;
  final String text;
  final String labelText;
  final double width;
  final double height;
  final int maxLines;

  const CustomTextFormWidget({
    super.key,
    required this.textController,
    required this.text,
    this.labelText = "",
    this.width = 147.0,
    this.height = 40.0,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '* ',
                style: KTextStyle.textStyle16.copyWith(color: Colors.red),
              ),
              TextSpan(
                text: text,
                style: KTextStyle.textStyle16.copyWith(color: AppColors.blackLight),
              ),
            ],
          ),
        ),
        SizedBox(
          width: width.w,
          height: height.h,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primaryBackground, width: 1.w),
              ),
            ),
            controller: textController,
            maxLines: maxLines,
          ),
        ),
      ],
    );
  }
}
