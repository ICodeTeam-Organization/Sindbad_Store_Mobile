import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String textTitle;
  final String? initialItem; // Add initial item

  const CustomDropdownWidget({
    super.key,
    required this.textTitle,
    required this.items,
    required this.hintText,
    this.initialItem, // Add initial item
  });

  @override
  Widget build(BuildContext context) {

        // Ensure initialItem is in the items list
    final String initialDropdownItem = items.contains(initialItem) ? initialItem! : items[1];

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
                  style: KTextStyle.textStyle16.copyWith(color: AppColors.greyDark),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0.h),
          SizedBox(
            width: 335.w,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomDropdown(
                hintText: hintText,
                items: items,
                // initialItem: initialItem ?? items[0], // Set initial item
                initialItem: initialDropdownItem, // Set initial item
                decoration: CustomDropdownDecoration(
                  closedBorder: Border.all(color: AppColors.grey),
                  expandedBorder: Border.all(color: AppColors.grey),
                ),
                onChanged: (value) {
                  print('changing value to: $value');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
