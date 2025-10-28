import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/styles/Colors.dart';
import '../../../../../config/styles/text_style.dart';

class TheOrder extends StatelessWidget {
  const TheOrder({
    super.key,
    required this.orderNumber,
    required this.billNumber,
    required this.clock,
    required this.date,
    required this.itemNumber,
    required this.paymentInfo,
  });
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final int itemNumber;
  final String paymentInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16.r)),
      height: 160.h,
      width: 380.w,
      child: Column(
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(16.r)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'رقم الطلب',
                      style: KTextStyle.textStyle11,
                    ),
                    Text(
                      orderNumber,
                      style: KTextStyle.textStyle14,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text('رقم الفاتورة', style: KTextStyle.textStyle11),
                    Text(
                      billNumber,
                      style: KTextStyle.textStyle14,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
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
                  '$clock - $date التاريخ',
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
                        '$itemNumber',
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
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                Text(paymentInfo, style: KTextStyle.textStyle12)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
