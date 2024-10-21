import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class KCardInfoPriceWidget extends StatelessWidget {
  final int orderAmount;
  final double Price;
  final double Total;
    final double Cost;
    final double totalCost ;


  final bool isShow;
  const KCardInfoPriceWidget({
    this.isShow = true,
    required this.orderAmount,
    required this.Price,
    required this.Total,
    required this.Cost,
    required this.totalCost,
  });
  // const card({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0.h),
      child: Container(
        height: 65.h,
        width: 346.w,
        decoration: BoxDecoration(
            border: Border.all(
          color: Color.fromRGBO(216, 214, 214, 1),
          width: 2.w,
        )),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0.w,
                  ),
                  child: Text(
                    "الكمية:",
                    style: KTextStyle.textStyle12
                        .copyWith(color: AppColors.greyHint),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8.0.w,
                    ),
                    child: Text(orderAmount.toString(),
                        style: KTextStyle.textStyle12
                            .copyWith(color: AppColors.black)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0.w,
                  ),
                  child: Text(
                    "السعر :",
                    style: KTextStyle.textStyle12
                        .copyWith(color: AppColors.greyHint),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8.0.w,
                    ),
                    child: Text(
                      Price.toString(),
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.redDark),
                    ),
                  ),
                ),
                if (isShow != true)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0.w,
                    ),
                    child: Text(
                      "التكلفة :",
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.greyHint),
                    ),
                  ),
                if (isShow != true)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 8.0.w,
                      ),
                      child: Text(
                        Cost.toString(),
                        style: KTextStyle.textStyle12
                            .copyWith(color: AppColors.redDark),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0.w,
                  ),
                  child: Text(
                    "الإجمالي :",
                    style: KTextStyle.textStyle12
                        .copyWith(color: AppColors.greyHint),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8.0.w,
                    ),
                    child: Text(
                      Total.toString(),
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
                if (isShow != true)
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0.w,
                    ),
                    child: Text(
                      "اجمالي التكلفة :",
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.greyHint),
                    ),
                  ),
                if (isShow != true)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 8.0.w,
                      ),
                      child: Text(
                        totalCost.toString(),
                        style: KTextStyle.textStyle12
                            .copyWith(color: AppColors.redDark),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
