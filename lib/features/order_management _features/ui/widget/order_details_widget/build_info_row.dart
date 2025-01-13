import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

// ignore: must_be_immutable
class BuildInfoRow extends StatelessWidget {
  BuildInfoRow({super.key, required this.title, required this.controller});
  final String title;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              title,
              style:
                  KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          // Spacer(),
          Expanded(
            child: SizedBox(
              // width: 200.w,
              height: 48.h,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey,
                      width: 1.w,
                    ),
                  ),
                ),
                style: KTextStyle.textStyle12
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
