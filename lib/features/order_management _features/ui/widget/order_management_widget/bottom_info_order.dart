import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/styles/Colors.dart';
import '../../../../../config/styles/text_style.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
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
              ],
            ),
          ),
          Padding(
            padding: (MediaQuery.sizeOf(context).width) >= 480
                ? const EdgeInsets.only(left: 35)
                : const EdgeInsets.only(left: 15),
            child: Row(
              children: [
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
          )
        ],
      ),
    );
  }
}
