import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class UpContent extends StatelessWidget {
  const UpContent({
    super.key,
    required this.offerStatus,
    required this.offerTitle,
  });

  final String offerStatus;
  final String offerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      child: Row(
        children: [
          Text(offerTitle,
              style:
                  KTextStyle.textStyle12.copyWith(color: AppColors.greyHint)),
          Text(offerStatus, style: KTextStyle.secondaryTitle),
        ],
      ),
    );
  }
}
