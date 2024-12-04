import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

String? companyName;
const List<String> _list = [
  'الافضل',
  'البراق',
  'السريع',
  'توصيل',
  'اخرى',
];

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5.h,
        ),
        Text(
          'اسم الشركة الناقلة',
          style: KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w600),
        ),
        CustomDropdown(
          closedHeaderPadding: EdgeInsets.all(5),
          // controller: dropDownController ,
          items: _list,
          hintText: " ",
          // initialItem: _list[0],
          onChanged: (value) {
            companyName = value;
            // log('changing value to: $companyName');
          },
          decoration: CustomDropdownDecoration(
              closedFillColor: Colors.transparent,
              closedBorder: Border.all(color: AppColors.grey)),
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }
}
