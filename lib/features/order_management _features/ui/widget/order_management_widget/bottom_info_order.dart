import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

class BottomInfoOrder extends StatelessWidget {
  const BottomInfoOrder({
    super.key,
    required this.date,
    required this.itemNumber,
  });

  final String date;
  final String itemNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(
            "assets/alarm.svg",
            width: 30.w,
            height: 30.h,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            date,
            style: KTextStyle.textStyle12,
          ),
          SizedBox(
            width: 65.w,
          ),
          SizedBox(
            width: 40.w,
            height: 40.h,
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  "assets/Bag.svg",
                  width: 40.w,
                  height: 40.h,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  itemNumber,
                  style: KTextStyle.textStyle12.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ]),
          ),
          Text('عدد الاصناف', style: KTextStyle.textStyle12),
        ],
      ),
    );
  }
}
