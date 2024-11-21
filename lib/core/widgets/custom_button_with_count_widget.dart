import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class KCustomButtonWithCountWidget extends StatelessWidget {
  final String partName;
  final int partCount;
  final String navigatorName;
  const KCustomButtonWithCountWidget(
      {super.key,
      required this.partName,
      required this.partCount,
      required this.navigatorName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          // onTap: partOnTap ,
          onTap: () {
            GoRouter.of(context).push(navigatorName);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.blueColor, // Add a background color if needed
              borderRadius:
                  BorderRadius.circular(20.0.r), // Adjust the radius as needed
              boxShadow: [
                BoxShadow(
                  // color: AppColors.greyHint.withOpacity(0.3),
                  color: AppColors.greyHint,
                  spreadRadius: 2.r,
                  blurRadius: 5.r,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    // 'إحصائيات',
                    partName,
                    style: KTextStyle.secondaryTitle
                    // TextStyle(fontSize: 15.sp,
                    // fontWeight: FontWeight.bold
                    // ),
                    ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  backgroundColor: AppColors.redDark,
                  radius: 18.r,
                  child: Center(
                      child: Text(partCount.toString(),
                          style: const TextStyle(color: AppColors.white))),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        )
      ],
    );
  }
}
