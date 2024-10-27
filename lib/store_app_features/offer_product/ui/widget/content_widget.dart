import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    super.key,
    required this.contentInfo,
    required this.contentTitle,
  });

  final String contentInfo;
  final String contentTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          contentTitle,
          style: KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.h),
          width: 150.w,
          height: 25.h,
          color: AppColors.primaryColor,
          child: Text(contentInfo),
        )
      ],
    );
  }
}
