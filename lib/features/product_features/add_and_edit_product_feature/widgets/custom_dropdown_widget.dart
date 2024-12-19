import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String textTitle;
  final bool enabled;
  final String? initialItem;
  // final SingleSelectController<String?>? controller;
  final dynamic Function(String?) onChanged;

  const CustomDropdownWidget({
    super.key,
    required this.textTitle,
    // this.controller,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.enabled = true,
    this.initialItem,
    // this.initialItem,
  });

  @override
  Widget build(BuildContext context) {
    // final String? initialDropdownItem =
    //     (items.isNotEmpty && items.contains(initialItem)) ? initialItem : null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '* ',
                  style: KTextStyle.textStyle14.copyWith(color: Colors.red),
                ),
                TextSpan(
                  text: textTitle,
                  style: KTextStyle.textStyle16
                      .copyWith(color: AppColors.greyDark),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0.h),
          SizedBox(
            width: 335.w,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomDropdown<String>(
                enabled: enabled,
                // controller: controller,
                hintText: hintText,
                items: items,
                initialItem: initialItem,
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: AppColors.grey),
                  expandedBorder: Border.all(color: AppColors.grey),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
