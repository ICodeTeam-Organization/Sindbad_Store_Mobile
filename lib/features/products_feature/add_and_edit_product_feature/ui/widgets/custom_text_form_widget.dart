import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/required_text.dart';

class CustomTextFormWidget extends StatelessWidget {
  final TextEditingController? textController;
  final String text;
  final String labelText;
  final double width;
  final double height;
  final int maxLines;
  final bool? enabled;
  final TextInputType keyboardType;
  final Function(String)? onFieldSubmitted;
  final bool? isRequired;
  final String? Function(String?)? validator;

  const CustomTextFormWidget({
    super.key,
    required this.textController,
    required this.text,
    this.labelText = "",
    this.keyboardType = TextInputType.text,
    this.width = 147.0,
    this.height = 40.0,
    this.maxLines = 1,
    this.enabled = true,
    this.onFieldSubmitted,
    this.isRequired = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Place label inside a Row and make the actual text expandable
          // so it truncates instead of causing layout errors in unbounded contexts.
          Row(
            children: [
              Expanded(
                child: isRequired == true
                    ? RequiredText(title: text)
                    : Text(
                        text,
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.greyLight,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
              ),
            ],
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            width: width.w,
            height: height.h,
            child: TextFormField(
              onFieldSubmitted: onFieldSubmitted,
              enabled: enabled,
              keyboardType: keyboardType,
              validator: validator ??
                  (isRequired == true
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return 'هذا الحقل مطلوب';
                          }
                          return null;
                        }
                      : null),
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
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
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
      ),
    );
  }
}
