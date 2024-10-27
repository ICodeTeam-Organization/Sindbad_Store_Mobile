import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class CustomLabelPart extends StatelessWidget {
  final String partName;
  final String partCount;
  // final Function()? partOnTap;
  final String navigatorName;
  const CustomLabelPart(
      {super.key,
      required this.partName,
      required this.partCount,
      //  required this.partOnTap,
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
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2.r,
                  blurRadius: 5.r,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // 'إحصائيات',
                  partName,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 18.r,
                  child: Center(
                      child: Text(partCount.toString(),
                          style: const TextStyle(color: Colors.white))),
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
