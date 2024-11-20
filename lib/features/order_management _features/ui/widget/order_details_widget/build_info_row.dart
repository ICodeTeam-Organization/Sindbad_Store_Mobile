import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import 'show_date_picker.dart';

// ignore: must_be_immutable
class BuildInfoRow extends StatelessWidget {
  BuildInfoRow(
      {super.key,
      required this.title,
      required this.isDate,
      required this.controller});
  final String title;
  final bool isDate;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: KTextStyle.textStyle12,
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 220.w,
            height: 48.h,
            child: TextField(
              readOnly: isDate,
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: isDate
                    ? ShowDatePicker() // أيقونة التاريخ
                    : null,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey,
                    width: 1.w,
                  ),
                ),
              ),
              style: KTextStyle.secondaryTitle.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
