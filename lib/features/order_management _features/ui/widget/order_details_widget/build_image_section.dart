import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import '../../function/image_picker_function.dart';

class BuildImageSection extends StatelessWidget {
  const BuildImageSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "صورة الفاتورة",
                  style: KTextStyle.textStyle16,
                ),
              ],
            ),
          ),
          const ImagePickerFunction(),
        ],
      ),
    );
  }
}
