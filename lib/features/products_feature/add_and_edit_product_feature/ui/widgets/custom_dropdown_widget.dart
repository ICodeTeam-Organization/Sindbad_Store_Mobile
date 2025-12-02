import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_feature/modify_offer_feature/ui/widgets/required_text.dart';

class CustomDropdownWidget extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String textTitle;
  final bool enabled;
  final String? initialItem;
  final dynamic Function(String?) onChanged;
  final bool? isRequired;
  final ScrollController? scrollController;

  const CustomDropdownWidget({
    super.key,
    required this.textTitle,
    required this.items,
    required this.hintText,
    required this.onChanged,
    this.enabled = true,
    this.initialItem,
    this.isRequired,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: isRequired ?? true
              ? RequiredText(title: textTitle)
              : Text(
                  textTitle,
                  style: KTextStyle.textStyle13.copyWith(
                    color: AppColors.greyLight,
                  ),
                ),
        ),
        SizedBox(height: 5.h),
        SizedBox(
          width: 400.w,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: CustomDropdown<String>(
              enabled: enabled,
              hintText: hintText,
              itemsScrollController: scrollController,
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
    );
  }
}
