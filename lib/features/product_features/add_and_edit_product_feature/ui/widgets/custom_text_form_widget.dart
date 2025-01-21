import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/required_text.dart';

class CustomTextFormWidget extends StatelessWidget {
  final TextEditingController textController;
  final String text;
  final String labelText;
  final double width;
  final double height;
  final int maxLines;
  final bool? enabled;

  const CustomTextFormWidget({
    super.key,
    required this.textController,
    required this.text,
    this.labelText = "",
    this.width = 147.0,
    this.height = 40.0,
    this.maxLines = 1,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredText(title: text),
        SizedBox(height: 10.0.h),
        SizedBox(
          width: width.w,
          height: height.h,
          child: TextFormField(
            enabled: enabled,
            decoration: InputDecoration(
              hintText: 'أكتب هنا...',
              hintStyle: KTextStyle.textStyle12.copyWith(
                color: AppColors.greyLight,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyBorder,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyBorder,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
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
